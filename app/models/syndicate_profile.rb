# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  belongs_to :syndicate
  has_one :attachment, as: :parent, dependent: :destroy

  after_create :update_profile_state

  private

  def update_profile_state
    profile_states = syndicate.profile_states
    profile_states[:profile_completed] = true
    syndicate.update(profile_states: profile_states)
  end
end
