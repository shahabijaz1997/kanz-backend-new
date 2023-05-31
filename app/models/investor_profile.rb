# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  belongs_to :investor
  belongs_to :country, foreign_key: :country_id

  validates_presence_of :country_id
  validates_presence_of :residence, if: -> { investor.individual_investor? }
  validates_presence_of :legal_name, if: -> { investor.investment_firm? }
end
