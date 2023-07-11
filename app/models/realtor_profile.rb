# frozen_string_literal: true

class RealtorProfile < ApplicationRecord
  belongs_to :realtor
  belongs_to :nationality, class_name: 'Country'
  belongs_to :residence, class_name: 'Country'

  validates_presence_of :no_of_properties

  def self.ransackable_attributes(auth_object = nil)
    %w[residence_id nationality_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[nationality residence]
  end
end
