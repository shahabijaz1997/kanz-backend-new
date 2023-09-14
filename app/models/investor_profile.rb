# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  include ProfileState

  belongs_to :investor
  belongs_to :country
  belongs_to :residence, class_name: 'Country', optional: true
  belongs_to :accreditation_option, class_name: 'Option'

  validates :residence, presence: { if: -> { investor.individual_investor? } }
  validates :legal_name, presence: { if: -> { investor.investment_firm? } }

  def self.ransackable_attributes(_auth_object = nil)
    %w[residence_id country_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[country residence]
  end
end
