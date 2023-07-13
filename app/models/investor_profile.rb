# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  belongs_to :investor
  belongs_to :country

  validates_presence_of :country_id
  validates_presence_of :residence, if: -> { investor.individual_investor? }
  validates_presence_of :legal_name, if: -> { investor.investment_firm? }

  after_create :update_profile_state

  def self.ransackable_attributes(auth_object = nil)
    %w[residence country_id]
  end

  def self.ransackable_associations(auth_object = nil)
    ['country']
  end

  private

  def update_profile_state
    profile_states = investor.profile_states
    profile_states[:profile_completed] = true
    investor.update(profile_states: profile_states)
  end
end
