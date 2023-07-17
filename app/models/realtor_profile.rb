# frozen_string_literal: true

class RealtorProfile < ApplicationRecord
  belongs_to :realtor
  belongs_to :nationality, class_name: 'Country'
  belongs_to :residence, class_name: 'Country'

  validates_presence_of :no_of_properties
  after_save :update_profile_state

  def self.ransackable_attributes(auth_object = nil)
    %w[residence_id nationality_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[nationality residence]
  end

  private

  def update_profile_state
    profile_states = realtor.profile_states
    profile_states[:profile_completed] = true
    realtor.update(profile_states: profile_states)
  end
end
