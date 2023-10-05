module Settings
  class ParamsMapper < ApplicationService
    attr_reader :params, :deal, :steppers, :step_titles, :step_titles_ar

    def initialize(deal, steppers)
      @deal = deal
      @params = StepperSerializer.new(steppers).serializable_hash[:data].map { |d| d[:attributes] }
      @step_titles = steppers.pluck(:title)
      @step_titles_ar = steppers.pluck(:title_ar)
    end

    def call
      update_steps_on_instrumentation
      map_startup_values

      { 
        step_titles: { en: step_titles, ar: step_titles_ar },
        steps: map_startup_values
      }
    end

    private

    def map_startup_values
      dependent_ids = dependent_field_ids
      steps = params.each do |step|
        sections = step[:en][:sections].each do |section|
          if section[:is_multiple]
            fields = map_multiple_fields(section[:fields])
          else
            fields = section[:fields].each do |field|
              value = if field[:id].in?(dependent_ids)
                selected_value(dependent_field(field[:id], field[:field_mapping]))
              else
                selected_value(field)
              end
              if field[:field_type].in? VALUE_FIELDS
                field[:value] = value
              elsif field[:field_type].in? OPTION_FIELDS
                options = field[:options].each do |option|
                  option[:selected] = (value.present? && option[:id] == value) ? true : false
                end
                field[:options] = options
              end
            end
          end
          section[:fields] = fields
        end
        step[:en][:sections] = sections
      end
      steps
    end

    def map_multiple_fields(fields)
      all_fields = []
      fields.each do |field|
        attribute = field[:field_mapping].split('.').first

        class_instance = class_name(attribute).constantize
        instances = class_instance.where(deal_id: deal.id, field_attribute_id: field[:id])
        instances.each do |instance|
          field[:value] = instance&.send(field[:field_mapping].split('.').last) 
          field[:index] = instance&.send(:index)
        end
        all_fields << field
      end
      all_fields
    end

    def dependent_field_ids
      FieldAttribute.pluck(:dependent_id).compact.uniq
    end

    def dependent_field(id, mapping)
      field = FieldAttribute.find_by(dependent_id: id)
      field[:field_mapping] = mapping
      field
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
      field = FieldAttribute.find_by(field_mapping: 'funding_round_attributes.instrument_type')
      option = field&.options&.find_by(statement: 'SAFE Round')
      if deal&.funding_round&.instrument_type == option&.id
        index = params.find_index {|step| step[:en][:title] == 'valuation' }
        @params = params.reject.with_index{|v, i| i == index }
        @step_titles = step_titles.reject.with_index{|v, i| i == index }
        @step_titles_ar = step_titles_ar.reject.with_index{|v, i| i == index }
      end
    end
  end
end
