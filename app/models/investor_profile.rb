# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  include ProfileState

  belongs_to :investor
  belongs_to :country, foreign_key: :country_id
  belongs_to :residence, class_name: 'Country', optional: true
  belongs_to :accreditation_option, class_name: 'Option'

  validates_presence_of :country_id
  validates_presence_of :residence, if: -> { investor.individual_investor? }
  validates_presence_of :legal_name, if: -> { investor.investment_firm? }

  def self.ransackable_attributes(auth_object = nil)
    %w[residence_id country_id]
  end

  def self.ransackable_associations(auth_object = nil)
    ['country', 'residence']
  end
end
