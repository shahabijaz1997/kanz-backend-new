module DealClosingModel
  class AcceptEarlyInvestments < Base
    def call
      refund_late_investment
    end

    private

    def refund_late_investment
      # refund investments after target completion
    end

    def late_investments
      # investments after target completed
      # refund those investments (pass investments ids)
    end
  end
end
