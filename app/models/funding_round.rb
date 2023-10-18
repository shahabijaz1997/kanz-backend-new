# frozen_string_literal: true

class FundingRound < ApplicationRecord
  belongs_to :deal

  def self.ransackable_attributes(_auth_object = nil)
    %w[instrument_type round]
  end
end
