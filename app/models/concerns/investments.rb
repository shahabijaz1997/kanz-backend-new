module Investments
  extend ActiveSupport::Concern
  include WalletHelper

  included do
    def create_invested_transaction
      self.transactions.create!(
        transaction_type: :debit,
        status: :invested,
        amount: deal.startup? ? usd_to_aed(self.amount) : self.amount,
        timestamp: DateTime.now,
        wallet: user.wallet,
        description: 'Amount debitted on investment.'
      )
    end

    def create_refunded_transaction
      if self.refunded?
        self.transactions.create!(
          transaction_type: :credit,
          status: :refunded,
          amount: self.transactions.last.amount,
          timestamp: DateTime.now,
          wallet: self.user.wallet,
          description: 'Investment amount refunded.'
        )
      end
    end
  end
end