module Deals
  class PublicDetails < ApplicationService
    attr_reader :deal
    def initialize(deal)
      @deal = deal
    end

    def call
      params = {
        id: deal.id,
        title: deal.title,
        description: deal.description,
        category: deal.deal_type,
        selling_price: deal.target,
        status: deal.status,
        start_at: deal.start_at.blank? ? '' : Date.parse(deal.start_at.to_s).strftime('%d/%m/%Y'),
        end_at: deal.end_at.blank? ? '' : Date.parse(deal.end_at.to_s).strftime('%d/%m/%Y'),
        token: deal.token
      }

      additional_params = deal.startup? ? startup_params : property_params
      params.merge(additional_params)
    end

    private

    def startup_params
      round = deal.funding_round
      return {} if round.blank?

      {
        stage: round.stage,
        instrument_type: round.instrument,
        equity_type: round.equity_kind,
        safe_type: round.safe_kind,
        valuation_type: round.valuation_type,
        valuation: round.valuation,
        terms: deal_terms
      }
    end

    def property_params
      property_detail = deal.property_detail
      return {} if property_detail.blank?

      {
        expected_dividend_yield: property_detail.dividend_yield,
        expected_annual_return: property_detail.yearly_appreciation,
        size: property_detail.size,
        features: property_features(property_detail),
        address: address(property_detail)
      }
    end

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

    def address(property_detail)
      {
        street_address: property_detail.street_address,
        building_name: property_detail.building_name,
        area: property_detail.area,
        city: property_detail.city,
        state: property_detail.state,
        country_name: property_detail.country_name
      }
    end

    def deal_terms
      terms = FieldAttribute.joins(:terms).where("terms.deal_id = #{deal.id}").pluck(:statement, :enabled, :custom_input)
      terms.map{ |term| { term: term[0], is_enabled: term[1], value: term[2] }}
    end
  end
end
