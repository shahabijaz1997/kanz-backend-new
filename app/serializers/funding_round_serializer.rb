# frozen_string_literal: true

# FundingRound  json serializer
class FundingRoundSerializer
  include JSONAPI::Serializer

  attribute :round do |fr|
    fr.stage
  end

  attribute :instrument_type do |fr|
    fr.instrument
  end

  attribute :safe_type do |fr|
    fr.safe_kind
  end

  attribute :equity_type do |fr|
    fr.equity_kind
  end

  attribute :valuation_phase do |fr|
    fr.valuation_type
  end

  attribute :valuation do |fr|
    fr.valuation
  end
end
