# frozen_string_literal: true

# FundingRound  json serializer
class FundingRoundSerializer
  include JSONAPI::Serializer

  attributes :id, :round, :instrument_type, :instrument_sub_type, :valuation_phase, :valuation
end
