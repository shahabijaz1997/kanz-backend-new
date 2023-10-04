module Settings
  class ParamsMapper < ApplicationService
    attr_reader :params, :deal

    def initialize(params, deal)
      @params = params
      @deal = deal
    end

    def call
      deal.startup? ? map_startup_values : map_property_values
    end

    private

    def map_startup_values
      dependent_ids = dependent_field_ids
      steps = params.each do |step|
        sections = step[:en][:sections].each do |section|
          puts section[:is_multiple]
          if section[:is_multiple]
            puts section[:is_multiple]
          else
            fields = section[:fields].each do |field|
              if field[:id].in?(dependent_ids)
                value = selected_value(dependent_field(field[:id], field[:field_mapping]))
              else
                value = selected_value(field)
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
            section[:fields] = fields
          end
        end
        step[:en][:sections] = sections
      end
      steps
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
      # deal.attachments.find_by(configurable: field)
      "url here"
    end
  end
end
