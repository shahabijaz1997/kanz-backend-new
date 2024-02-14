module ActivityRecorder
  class Deal < ApplicationService
    attr_reader :params, :deal, :user 

    def initialize(params, deal, user)
      @params = params
      @deal = deal
      @user = user
    end

    def call
      record_target_change
      record_valuation_change if deal.funding_round.present?
      record_rental_change if deal.property_detail.present?
      record_rental_cycle_change if deal.property_detail.present?
    end

    private

    def record_target_change
      return if params[:target].blank?

      update_valuation_multiple(params[:target], deal.target) if deal.property?
      record_activity('target', deal.target, params[:target])
    end

    def record_valuation_change
      return if params[:funding_round_attributes].blank?

      valuation = params[:funding_round_attributes][:valuation]
      update_valuation_multiple(valuation, deal.funding_round.valuation)
      record_activity('valuation', deal.funding_round.valuation, valuation)
      valuation_phase = Option.find_by(id: params[:funding_round_attributes][:valuation_phase_id]).statement
      record_activity('valuation_phase', deal.valuation_phase, valuation_phase)
    end

    def record_rental_change
      return if params[:property_detail_attributes].blank? || params[:property_detail_attributes][:rental_amount].blank?

      rental_amount = params[:property_detail_attributes][:rental_amount]
      record_activity('rental_amount', deal.property_detail.rental_amount, rental_amount)
    end

    def record_rental_cycle_change
      return if params[:property_detail_attributes].blank? || params[:property_detail_attributes][:rental_period_id].blank?

      rental_duration = Option.find_by(id: params[:property_detail_attributes][:rental_period_id]).statement
      record_activity('rental_duration', deal.rental_duration, rental_duration)
    end

    def record_activity(field_name, old_value, new_value)
      activity = Activity.new(field_name: field_name,
                              new_value: new_value,
                              old_value: old_value,
                              action: Activity::actions[:modified])
      activity.user = user
      activity.record = deal
      activity.save!
    end

    def update_valuation_multiple(new_value, old_value)
      multiple = new_value.to_f / old_value
      multiple = deal.valuation_multiple.to_f > 0 ? deal.valuation_multiple.to_f * multiple : multiple
      deal.update!(valuation_multiple: multiple)
    end
  end
end
