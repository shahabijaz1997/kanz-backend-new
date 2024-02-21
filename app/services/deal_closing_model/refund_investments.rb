# frozen_string_literal: true

module DealClosingModel
  class RefundInvestments < Base
    def call
      Investment.transaction do
        deal.investments.each(&:refunded!)
      end
    end
  end
end
