# frozen_string_literal: true
module DealAttributesUtility
  def minimum_check_size
    terms.minimum_check_size.first&.custom_input.to_f
  end

  def investment_round
    funding_round&.stage
  end

  def rental_duration
    property_detail&.rental_duration
  end

  def valuation_phase
    funding_round&.valuation_type
  end
end
