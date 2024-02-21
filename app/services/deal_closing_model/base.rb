module DealClosingModel
  class Base < ApplicationService
    include Investments

    attr_reader :deal

    def initialize(deal)
      super()
      @deal = deal
    end

    def call
      case deal.closing_model
      when 'fifs'
        AcceptEarlyInvestments.call(deal)
      when 'adjust_pro_rata'
        AdjustProRata.call(deal)
      when 'refunded_and_closed'
        RefundInvestments.call(deal)
      end
    end
  end
end
