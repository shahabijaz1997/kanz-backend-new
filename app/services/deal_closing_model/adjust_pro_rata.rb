module DealClosingModel
  class AdjustProRata < Base
    include WalletHelper

    attr_reader :deal

    def initialize(deal)
      super
    end

    def call
      target = deal.target.to_f
      invested_amount = deal.investments.sum(:amount)
      return if invested_amount <= target

      percentage_to_invest = target/invested_amount
      percentage_to_refund = 1 - percentage_to_invest

      refund(percentage_to_invest, percentage_to_refund)
    end

    private

    def refund(percentage_to_invest, percentage_to_refund)
      Investment.transaction do
        deal.investments.each do |investment|
          invested_amount = amount_to_invest(amount, percentage_to_invest)
          refunded_amount = amount_to_refund(amount, percentage_to_refund)
          investment.update(amount: invested_amount)
          investment.refunded_investment_portion(refunded_amount)
        end
      end
    end

    def amount_to_invest(amount, percent)
      amount * percent
    end

    def amount_to_refund(amount, percent)
      value = amount * percent
      deal.startup? ? usd_to_aed(value) : value
    end
  end
end
