# frozen_string_literal: true

class Country < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    ['name']
  end
end
