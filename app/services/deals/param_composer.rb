module Deals
  class ParamComposer < ApplicationService
    attr_reader :params, :deal

    def initialize(params, deal)
      @params = params
      @deal = deal
    end

    def call
      return response('Invalid Step') unless valid_step
      return response('Invalid Fields') unless valid_fields

      response('success', true, deal_params, 200)
    end

    private

    def valid_step
      type = deal.startup? ? STEPPERS[:startup_deal] : STEPPERS[:property_deal]
      Stepper.exists?(id: params[:step], stepper_type: type)
    end

    def valid_fields
      params[:fields].present? && params[:fields].none? { |f| f[:id].blank? || f[:id].blank? }
    end

    def deal_params
      step = Stepper.find_by(id: params[:step])
      params_hash = { step: step&.index || 0 }
      dependent_ids = dependent_field_ids

      params[:fields].each do |_field|
        field = FieldAttribute.find_by(id: _field[:id])
        next if dependent_ids.include?(_field[:id]) || field.blank?
        next if field.field_type == 'file'

        field_params = build_field_params(field, _field)
        if one_to_many_relation?(field_params)
          key = field_params.keys.first
          params_hash[key] ||= []
          params_hash[key] << field_params[key]
        else
          params_hash = params_hash.deep_merge(field_params)
        end
      end

      params_hash
    end

    def dependent_field_ids
      FieldAttribute.pluck(:dependent_id).compact.uniq
    end

    def one_to_many_relation?(field_params)
      ["terms_attributes", "features_attributes", "external_links_attributes"].include?(field_params.keys.first)
    end

    def build_field_params(field, _field)
      field_params = build_nested_hash(field.field_mapping, _field[:value], _field[:id])
      object_params = existing_object(field.field_mapping, _field[:id])
      field_params = field_params.deep_merge(object_params)

      dependent_field = field.dependent_field
      dependent_field.present? ? field_params.deep_merge(build_dependent_hash(dependent_field)) : field_params
    end

    def build_dependent_hash(field)
      field_params = params[:fields].detect {|f| f[:id] == field.id }
      value = field_params.present? ? { value: field_params[:value] } : {}
      build_hash(field.field_mapping, value)
    end

    def build_nested_hash(mapping, value, id)
      field_params = build_hash(mapping, value)

      mapping_arr = mapping.split('.')
      if mapping_arr.first.in?(["terms_attributes", "features_attributes", "external_links_attributes"])
        mapping_arr.pop()
        mapping = mapping_arr.push('field_attribute_id').join('.')

        field_params = field_params.deep_merge(build_hash(mapping, id))
      end
      field_params
    end

    def build_hash(mapping, value)
      mapping.split('.').reverse.inject(value) { |v, k| { k => v } }
    end

    def existing_object(mapping, id = 0)
      key = mapping.split('.').first
      return {} unless deal.persisted?

      class_name = class_name(key)
      return {} if class_name.blank?

      hash = {}
      instance = if class_name.in?(['Feature', 'Term']) 
        class_name.constantize.find_by(deal_id: deal.id, field_attribute_id: id)
      else
        class_name.constantize.find_by(deal_id: deal.id)
      end
      hash[key] = { 'id' => instance.id } if instance.present?
      hash
    end

    def class_name(key)
      word_arr = key.split('_')
      return if word_arr.last != 'attributes'

      word_arr.pop
      word_arr.map{|w| w.titleize }.join('').singularize
    end
  end
end
