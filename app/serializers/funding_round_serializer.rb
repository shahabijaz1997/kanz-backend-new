# frozen_string_literal: true

# FundingRound  json serializer
class FundingRoundSerializer
  include JSONAPI::Serializer

  attribute :round do |fr|
    option_value(fr.round)
  end

  attribute :instrument_type do |fr|
    option_value(fr.instrument_type)
  end

  attribute :safe_type do |fr|
    option_value(fr.safe_type)
  end

  attribute :equity_type do |fr|
    option_value(fr.equity_type)
  end

  attribute :valuation_phase do |fr|
    option_value(fr.valuation_phase)
  end

  attribute :valuation do |fr|
    fr.valuation
  end

  private

  class << self
    def option_value(id)
      Option.find_by(id: id)&.statement
    end
  end
end
