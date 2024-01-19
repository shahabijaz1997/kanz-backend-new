# frozen_string_literal: true

class FundingRound < ApplicationRecord
  belongs_to :deal

  belongs_to :round, class_name: 'Option', optional: true
  belongs_to :instrument_type, class_name: 'Option', optional: true
  belongs_to :safe_type, class_name: 'Option', optional: true
  belongs_to :equity_type, class_name: 'Option', optional: true
  belongs_to :valuation_phase, class_name: 'Option', optional: true

  scope :equity, -> { where.not(equity_type_id: nil) }

  def stage
    I18n.locale == :en ? round&.statement : round&.statement_ar
  end

  def instrument
    I18n.locale == :en ? instrument_type&.statement : instrument_type&.statement_ar
  end

  def equity_kind
    I18n.locale == :en ? equity_type&.statement : equity_type&.statement_ar
  end

  def safe_kind
    I18n.locale == :en ? safe_type&.statement : safe_type&.statement_ar
  end

  def valuation_type
    I18n.locale == :en ? valuation_phase&.statement : valuation_phase&.statement_ar
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[instrument_type_id round_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[instrument_type round]
  end
end
