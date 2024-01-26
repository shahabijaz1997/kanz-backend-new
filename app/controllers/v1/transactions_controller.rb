# frozen_string_literal: true
module V1
  class TransactionsController < ApiController
    include PagyHelper
    before_action :set_wallet

    def index
      @pagy, @transactions = pagy(@wallet.transactions)
      render json: {
        transactions: TransactionSerializer.new(@transactions).serializable_hash[:data].map{ |object| object[:attributes]},
        pagination: pagy_attributes(@pagy)
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
    params.require(:transaction).require(%i[amount method timestamp receipt])
    params.require(:transaction).permit(%i[amount method timestamp receipt])
    end
  end
end