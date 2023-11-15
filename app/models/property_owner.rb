# frozen_string_literal: true

class PropertyOwner < User
  has_one :profile, class_name: 'PropertyOwnerProfile', dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['profile']
  end
end
