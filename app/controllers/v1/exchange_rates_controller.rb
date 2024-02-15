# frozen_string_literal: true
module V1
  class ExchangeRatesController < ApiController
    def show
      render json: { exchange_rate: ExchangeRate.current.rate }
    end
  end
end