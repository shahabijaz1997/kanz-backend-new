module DealClosingModel
  class RefundInvestments < Base
    def initialize(deal)
      super
    end

    def call
      Investment.transaction do
        deal.investments.each do |investment|
          investment.refunded!
          create_refunded_transaction
        end
      end
    end
  end
end
