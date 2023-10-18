# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  belongs_to :deal

  def self.ransackable_attributes(_auth_object = nil)
    %w[size rental_amount is_rental]
  end
end
