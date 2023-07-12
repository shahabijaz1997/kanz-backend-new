# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  attr_accessor :step
  belongs_to :syndicate
  has_one :attachment, as: :parent, dependent: :destroy

  validates :profile_link, :dealflow, presence: true
  validates :raised_amount, :no_times_raised, presence: true, if: :raised_before?
  validates :name, :tagline, :logo, presence: true, if: :second_step?

  after_create :update_profile_state

  private

  def update_profile_state
    profile_states = syndicate.profile_states
    profile_states[:profile_completed] = true
    syndicate.update(profile_states: profile_states)
  end

  def raised_before?
    have_you_ever_raised
  end

  def second_step?
    step == 2
  end
end
