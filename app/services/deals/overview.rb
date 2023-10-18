module Deals
  class Overview < ApplicationService
    attr_reader :deal
    def initialize(deal)
      @deal = deal
    end

    def call
      deal_params
    end

    private

    def deal_params
      params = {
        raised: total_raised,
        committed: total_committed,
        investors: total_investors,
        selling_price: deal.target,
        title: deal.title,
        description: deal.description,
        status: deal.status,
        start_at: deal.start_at,
        end_at: deal.end_at,
      }

      additional_params = deal.startup? ? startup_params : property_params
      params.merge(additional_params)
    end

    def startup_params
      round = deal.funding_round
      return {} if round.blank?

      {
        stage: round.stage,
        instrument_type: round.instrument,
        equity_type: round.equity_kind,
        safe_type: round.safe_kind,
        valuation: round.valuation_type,
        valuation: round.valuation,
      }
    end

    def property_params
      property_detail = deal.property_detail
      return {} if property_detail.blank?

      params = {
        expected_dividend_yield: property_detail.dividend_yeild,
        expected_annual_return: property_detail.yearly_appreciation,
        size: property_detail.size,
        features: {},
        location: property_detail.location_detail
      }

      params[:features][:bedrooms] = property_detail.no_bedrooms if property_detail.has_bedrooms
      params[:features][:kitchen] = property_detail.no_kitchen if property_detail.has_kitchen
      params[:features][:washrooms] = property_detail.no_washrooms if property_detail.has_washroom
      params[:features][:parking_space] = property_detail.parking_capacity if property_detail.has_parking
      params[:features][:swimming_pool] = property_detail.swimming_pool_type if property_detail.has_swimming_pool
      params[:features][:rental_amount] = property_detail.rental_amount if property_detail.is_rental
      params[:features][:rental_period] = property_detail.rental_duration if property_detail.is_rental

      params
    end

    def total_raised
      # how_much_funded
      # Implement to calculate total raised from invoices
      0
    end

    def total_committed
      # Implement to calculate total committed from comitments, Need to decide 
      0
    end

    def total_investors
      # investors.count
      0
    end
  end
end
