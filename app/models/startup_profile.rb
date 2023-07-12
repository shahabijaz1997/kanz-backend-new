# frozen_string_literal: true

class StartupProfile < ApplicationRecord
  attr_accessor :step
  belongs_to :startup
  belongs_to :country
  has_one :attachment, as: :parent, dependent: :destroy

  validates :company_name, :legal_name, presence: true
  validates :total_capital_raised, :current_round_capital_target,
            :ceo_name, :ceo_email, :currency, presence: true, if: :second_step?

  after_create :update_profile_state

  private

  def update_profile_state
    profile_states = startup.profile_states
    profile_states[:profile_completed] = true
    startup.update(profile_states: profile_states)
  end

  def second_step?
    step == 2
  end
end
