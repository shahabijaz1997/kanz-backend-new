# frozen_string_literal: true

class Industry < ApplicationRecord
  has_many :profiles_industries, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[id]
  end
end
