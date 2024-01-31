# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  include ProfileState

  belongs_to :investor
  belongs_to :country
  belongs_to :residence, class_name: 'Country', optional: true
  belongs_to :accreditation_option, class_name: 'Option'

  validates :residence, presence: { if: -> { investor.individual_investor? } }
  validates :legal_name, presence: { if: -> { investor.investment_firm? } }

  accepts_nested_attributes_for :investor, update_only: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[residence_id country_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[country residence]
  end

  def accreditation
    I18n.locale == :en ? accreditation_option&.statement : accreditation_option&.statement_ar
  end

  def country_of_residence
    I18n.locale == :en ? residence&.name : residence&.name_ar
  end

  def nationality
    I18n.locale == :en ? country&.name : country&.name_ar
  end
end
