# frozen_string_literal: true
module V1
  class TransactionsController < ApiController
    before_action :set_wallet

    def index
      render json: {
        transactions: TransactionSerializer.new(@wallet.transactions).serializable_hash[:data].map{ |object| object[:attributes]}
      }
    end

    def create
      @transaction = @wallet.transactions.new(
        **permitted_params,
        transaction_type: :deposit,
        description: 'User deposited the amount in Kanz Bank Account'
      )
      if @transaction.save!
        render json: {
          transactions: TransactionSerializer.new(@wallet.transactions).serializable_hash[:data].map{ |object| object[:attributes]}
        }
      end
    end

    private

    def set_wallet
      @wallet = current_user.wallet
    end

    def permitted_params
      params.require(:transaction).permit(:amount, :method, :timestamp, :receipt)
    end
  end
end