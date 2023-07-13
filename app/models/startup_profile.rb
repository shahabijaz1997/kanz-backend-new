# frozen_string_literal: true

class StartupProfile < ApplicationRecord
  belongs_to :startup
  belongs_to :country
  has_one :attachment, as: :parent, dependent: :destroy

  validates :company_name, :legal_name, :total_capital_raised,
            :current_round_capital_target, :ceo_name, :ceo_email,
            :currency, presence: true

  after_create :update_profile_state

  def self.ransackable_attributes(auth_object = nil)
    %w[company_name legal_name industry_market]
  end

  private

  def update_profile_state
    profile_states = startup.profile_states
    profile_states[:profile_completed] = true
    startup.update(profile_states: profile_states)
  end
end
