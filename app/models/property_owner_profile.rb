# frozen_string_literal: true

class PropertyOwnerProfile < ApplicationRecord
  include ProfileState

  belongs_to :property_owner
  belongs_to :nationality, class_name: 'Country'
  belongs_to :residence, class_name: 'Country'

  validates :no_of_properties, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[residence_id nationality_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[nationality residence]
  end
end
