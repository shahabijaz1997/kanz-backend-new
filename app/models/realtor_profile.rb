# frozen_string_literal: true

class RealtorProfile < ApplicationRecord
  belongs_to :realtor
  belongs_to :nationality, class_name: 'Country'
  belongs_to :residence, class_name: 'Country'

  validates_presence_of :no_of_properties
  after_create :update_profile_state

  private

  def update_profile_state
    profile_states = realtor.profile_states
    profile_states[:profile_completed] = true
    realtor.update(profile_states: profile_states)
  end
end
