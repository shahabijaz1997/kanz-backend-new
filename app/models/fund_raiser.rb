# frozen_string_literal: true

class FundRaiser < User
  has_one :profile, class_name: 'FundRaiserProfile', dependent: :destroy

  accepts_nested_attributes_for :profile, update_only: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[profile]
  end
end
