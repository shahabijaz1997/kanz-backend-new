# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  belongs_to :investor
  belongs_to :country, foreign_key: :country_id

  validates_presence_of :country_id
  validates_presence_of :residence, if: -> { investor.individual_investor? }
  validates_presence_of :legal_name, if: -> { investor.investment_firm? }

  after_create :update_profile_state

  private

  def update_profile_state
    profile_states = investor.profile_states
    profile_states[:profile_completed] = true
    investor.update(profile_states: profile_states)
  end
end
