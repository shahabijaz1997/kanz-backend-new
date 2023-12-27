# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  belongs_to :deal

  belongs_to :swimming_pool, class_name: 'Option', optional: true
  belongs_to :rental_period, class_name: 'Option', optional: true
  belongs_to :country, class_name: 'Option'

  def swimming_pool_type
    I18n.locale == :en ? swimming_pool&.statement : swimming_pool&.statement_ar
  end

  def rental_duration
    I18n.locale == :en ? rental_period&.statement : rental_period&.statement_ar
  end

  def country_name
    I18n.locale == :en ? country&.statement : country&.statement_ar
  end

  def location_detail
    [street_address, building_name, area, city, state, country_name].join(', ')
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[size rental_amount is_rental]
  end
end
