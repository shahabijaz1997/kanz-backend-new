class DealActivityRecorder
  attr_reader :params, :record, :user 

  def initialize(params, record, user)
    @params = params
    @record = record
    @user = user
  end

  def call
    record_target_change
    record_valuation_change
    record_rental_change
  end

  private

  def record_target_change
    return if params[:target].blank?

    record_activity('target', record.target, params[:target])
  end

  def record_valuation_change
    return if params[:funding_round_attributes].blank?

    new_value = params[:funding_round_attributes][:valuation]
    record_activity('valuation', record.valuation, new_value)
    new_value = params[:funding_round_attributes][:valuation_phase_id]
    record_activity('valuation_phase', record.valuation_phase, new_value)
  end

  def record_rental_change
    return if params[:property_detail_attributes].blank?

    new_value = params[:property_detail_attributes][:rental_amount]
    record_activity('rental_amount', record.rental_amount, new_value)
    new_value = params[:property_detail_attributes][:rental_period_id]
    record_activity('rental_amount', record.rental_duration, new_value)
  end

  def record_activity(field_name, old_value, new_value)
    record.activities.create!(user: user,
                              field_name: field_name,
                              new_value: new_value,
                              old_value: old_value)
  end
end
