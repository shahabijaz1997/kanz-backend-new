# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  belongs_to :deal

  def self.ransackable_attributes(_auth_object = nil)
    %w[size rental_amount is_rental]
  end

  belongs_to :swimming_pool, class_name: 'Option'
  belongs_to :rental_period, class_name: 'Option'
  belongs_to :country, class_name: 'Option'

  def swimming_pool_type
    swimming_pool&.statement
  end

  def rental_duration
    rental_period&.statement
  end

  def country_name
    country&.statement
  end
end
