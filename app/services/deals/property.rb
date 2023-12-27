module Deals
  class Property < ApplicationService
    attr_reader :deal

    def initialize(deal)
      @deal = deal
    end

    def call()
      detail = deal.property_detail
      return {} if detail.blank?

      {
        expected_dividend_yield: detail.dividend_yield,
        expected_annual_return: detail.yearly_appreciation,
        size: detail.size,
        features: property_features(detail),
        address: address(detail),
        unique_selling_points: property_usps,
        external_links: external_links,
        terms: terms
      }
    end

    private

    def property_features(features)
      feature = {}
      feature[:has_bedrooms] = features.has_bedrooms
      feature[:bedrooms] = features.no_bedrooms if features.has_bedrooms
      feature[:has_kitchen] = features.has_kitchen
      feature[:kitchen] = features.no_kitchen if features.has_kitchen
      feature[:has_washroom] = features.has_washroom
      feature[:washrooms] = features.no_washrooms if features.has_washroom
      feature[:has_parking] = features.has_parking
      feature[:parking_space] = features.parking_capacity if features.has_parking
      feature[:has_swimming_pool] = features.has_swimming_pool
      feature[:swimming_pool] = features.swimming_pool_type if features.has_swimming_pool
      feature[:is_rental] = features.is_rental
      feature[:rental_amount] = features.rental_amount if features.is_rental
      feature[:rental_period] = features.rental_duration if features.is_rental

      feature
    end

    def address(detail)
      {
        street_address: detail.street_address,
        building_name: detail.building_name,
        area: detail.area,
        city: detail.city,
        state: detail.state,
        country_name: detail.country_name
      }
    end

    def property_usps
      deal.features.map do |usp|
        {
          title: usp.title,
          description: usp.description
        }
      end
    end

    def external_links
      deal.external_links.map do |link|
        link.url
      end
    end

    def terms
      FieldAttribute.find_by(field_mapping: 'agreed_with_kanz_terms')&.description
    end

  end
end
