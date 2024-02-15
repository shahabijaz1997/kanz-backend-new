module DealClosingModel
  class RefundInvestments < Base
    def initialize(deal)
      super
    end

    def call
      Investment.transaction do
        deal.investments.each do |investment|
          investment.refund
        end
      end
    end
  end
end
