# frozen_string_literal: true

class Startup < User
  has_one :profile, class_name: 'StartupProfile', dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[profile]
  end
end
