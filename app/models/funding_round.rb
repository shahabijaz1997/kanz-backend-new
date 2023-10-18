# frozen_string_literal: true

class FundingRound < ApplicationRecord
  belongs_to :deal

  def self.ransackable_attributes(_auth_object = nil)
    %w[instrument_type round]
  end

  belongs_to :round, class_name: 'Option', optional: true
  belongs_to :instrument_type, class_name: 'Option', optional: true
  belongs_to :safe_type, class_name: 'Option', optional: true
  belongs_to :equity_type, class_name: 'Option', optional: true
  belongs_to :valuation_phase, class_name: 'Option', optional: true

  def stage
    round&.statement
  end

  def instrument
    instrument_type&.statement
  end

  def equity_kind
    equity_type&.statement
  end

  def safe_kind
    safe_type&.statement
  end

  def valuation_type
    valuation_phase&.statement
  end
end
