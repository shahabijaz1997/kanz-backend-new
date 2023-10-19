module Settings
  class ParamsMapper < ApplicationService
    attr_reader :params, :deal, :review, :step_titles, :step_titles_ar

    def initialize(deal, steppers, review = false)
      @deal = deal
      @params = StepperSerializer.new(steppers).serializable_hash[:data].map { |d| d[:attributes] }
      @step_titles = steppers.pluck(:title)
      @step_titles_ar = steppers.pluck(:title_ar)
      @review = review
    end

    def call
      if deal.present?
        update_steps_on_instrumentation
        @params = map_values
        @params = update_for_review if review
      end

      {
        step_titles: { en: step_titles, ar: step_titles_ar },
        steps: params,
        current_state: @deal&.current_state || {}
      }
    end

    private

    def map_values
      dependent_ids = dependent_field_ids
      steps = params.each do |step|
        sections = step[:en][:sections].each do |section|
          if section[:is_multiple]
            fields = map_multiple_fields(section[:fields]) 
          else
            fields = section[:fields].each do |field|
              this_field = field[:id].in?(dependent_ids) ? dependent_field(field) : field
              value = selected_value(this_field)

              if field[:field_type].in? OPTION_FIELDS
                options = field[:options].each do |option|
                  selected = value.present? && option[:id] == value
                  value = option[:statement] if selected
                  option[:selected] = selected ? true : false
                end
                field[:options] = options
              end
              value = parsed_date(value) if is_date_value?(field[:field_mapping])
              field[:value] = value
            end
          end
          section[:fields] = fields
        end
        step[:en][:sections] = sections
      end
      steps
    end

    def is_date_value?(mapping)
      mapping.in? DEAL_STEPPER_DATE_FIELDS
    end

    def parsed_date(value)
      return value if value.blank?

      Date.parse(value.to_s).strftime('%d/%m/%Y')
    end

    def map_multiple_fields(fields)
      all_fields = []
      fields.each do |field|
        field_mapping = field[:field_mapping].split('.')

        temp_fields = class_name(field_mapping.first).constantize.where(deal_id: deal.id).map do |instance|
          field.merge({ value: instance.send(field_mapping.last), index: instance.index })
        end

        all_fields << (temp_fields.present? ? temp_fields : field)
      end
      all_fields.flatten(1)
    end

    def dependent_field_ids
      FieldAttribute.pluck(:dependent_id).compact.uniq
    end

    def dependent_field(field)
      temp_field = FieldAttribute.find_by(dependent_id: field[:id])
      temp_field[:field_mapping] = field[:field_mapping]
      temp_field
    end

    def one_to_many_relation?(field_params)
      ["terms_attributes", "features_attributes"].include?(field_params.keys.first)
    end

    def selected_value(field)
      return file_url(field) if field[:field_type] == 'file'

      attribute_name = field[:field_mapping].split('.').first
      return deal.send(attribute_name) unless association?(attribute_name)

      class_name = class_name(attribute_name)
      instance = if class_name.in?(['Feature', 'Term'])
        class_name.constantize.find_by(deal_id: deal.id, field_attribute_id: field[:id])
      else
        class_name.constantize.find_by(deal_id: deal.id)
      end
      instance&.send(field[:field_mapping].split('.').last)
    end

    def class_name(key)
      word_arr = key.split('_')
      word_arr.pop
      word_arr.map{|w| w.titleize }.join('').singularize
    end

    def association?(key)
      key.split('_').last == 'attributes'
    end

    def file_url(field)
      attachment = deal.attachments&.find_by(configurable_type: 'FieldAttribute', configurable_id: field[:id])
      { id: attachment&.id, url: attachment&.url }
    end

    def update_steps_on_instrumentation
      return if deal.property?

      if instrument_type?('SAFE')
        update_terms_step('safe')
        remove_step('valuation')
        remove_step('stage')
      elsif instrument_type?('Equity Financing')
        update_terms_step('equity')
      end

    end

    def instrument_type?(instrument_type)
      field = FieldAttribute.find_by(field_mapping: 'funding_round_attributes.instrument_type_id')
      option = field&.options&.find_by(statement: instrument_type)
      deal&.funding_round&.instrument_type_id == option&.id
    end

    def remove_step(step_title)
      index = params.find_index {|step| step[:en][:title] == step_title }
      @params = params.reject.with_index{|v, i| i == index }
      update_step_titles(index)
    end

    def update_step_titles(index)
      @step_titles = step_titles.reject.with_index{|v, i| i == index }
      @step_titles_ar = step_titles_ar.reject.with_index{|v, i| i == index }
    end

    def update_terms_step(instrument_type) 
      @params = params.map do |step|
        temp = step
        if step[:en][:title] == 'terms'
          temp = temp[:en][:sections].reject {|section| section[:condition] != instrument_type }
          step[:en][:sections] = temp
        end
        step
      end
    end

    def update_for_review
      params.map do |step|
        current_step = { id: step[:id], index: step[:index], title: step[:en][:title], fields: [] }
        step[:en][:sections].each do |section|
          current_step[:fields] << section[:fields].map do |field|
            if section[:is_multiple]
              { statement: field[:statement], value: field[:value], index: field[:index], unit: unit(field[:input_type]) }
            else
              { statement: field[:statement], value: field[:value], unit: unit(field[:input_type]) }
            end
          end
        end
        current_step[:fields] = current_step[:fields].flatten(1)
        current_step
      end
    end

    def unit(input_type = nil)
      return '' if input_type.blank? || input_type == 'number'

      return '$' if input_type == 'currency'
      return '%' if input_type == 'percent'
      return 'sqft' if input_type == 'sqft'
    end
  end
end
