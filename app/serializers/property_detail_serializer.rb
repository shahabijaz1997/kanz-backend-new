# frozen_string_literal: true

# Details json serializer
class PropertyDetailSerializer
  include JSONAPI::Serializer
  attributes :state, :city, :area, :location, :building_name, :street_address, :size,
             :has_bedrooms, :no_bedrooms, :has_kitchen, :no_kitchen, :has_washroom,
             :no_washrooms, :has_parking, :parking_capacity, :has_swimming_pool,
             :is_rental, :rental_amount, :dividend_yeild, :yearly_appreciation

  attribute :country_id do |pd|
    pd.country_name
  end

  attribute :swimming_pool_type do |pd|
    pd.swimming_pool_type
  end

  attribute :rental_period do |pd|
    pd.rental_duration
  end
end
