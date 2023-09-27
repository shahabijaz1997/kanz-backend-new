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
      params_hash = {}
      params[:fields].each do |field|
        step_field = FieldAttribute.find_by(id: field[:id])
        field_params = step_field.field_mapping.split('.').reverse.inject(field[:value]) { |v, k| { k => v } }
        params_hash = params_hash.deep_merge(field_params)
      end

      params_hash
    end

  end
end