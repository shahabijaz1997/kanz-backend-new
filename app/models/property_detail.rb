# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  belongs_to :deal

  def self.ransackable_attributes(_auth_object = nil)
    %w[size rental_amount is_rental]
  end

  belongs_to :swimming_pool_type, class_name: 'Option', foreign_key: 'swimming_pool_type'
  belongs_to :rental_period, class_name: 'Option', foreign_key: 'rental_period'
  belongs_to :country, class_name: 'Option', foreign_key: 'country_id'

  def swimming_pool
    swimming_pool_type&.statement
  end

  def rental_duration
    rental_period&.statement
  end

  def country_name
    country&.statement
  end
end
