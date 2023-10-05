# frozen_string_literal: true

# Details json serializer
class PropertyDetailSerializer
  include JSONAPI::Serializer
  attributes :state, :city, :area, :location, :building_name, :street_address, :size,
             :has_bedrooms, :no_bedrooms, :has_kitchen, :no_kitchen, :has_washroom,
             :no_washrooms, :has_parking, :parking_capacity, :has_swimming_pool,
             :is_rental, :rental_period, :rental_amount, :dividend_yeild, :yearly_appreciation,
             :external_links

  attribute :country_id do |pd|
    option_value(pd.country_id)
  end

  attribute :swimming_pool_type do |pd|
    option_value(pd.swimming_pool_type)
  end

  attribute :rental_period do |pd|
    option_value(pd.rental_period)
  end

  private

  class << self
    def option_value(id)
      Option.find_by(id: id)&.statement
    end
  end
end
