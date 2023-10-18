# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  belongs_to :deal

  belongs_to :swimming_pool, class_name: 'Option', optional: true
  belongs_to :rental_period, class_name: 'Option', optional: true
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

  def location_detail
    [street_address, building_name, area, city, state, country_name].join(', ')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[size rental_amount is_rental]
  end
end
