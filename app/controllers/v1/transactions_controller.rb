# frozen_string_literal: true
module V1
  class TransactionsController < ApiController
    require 'stripe'
    include PagyHelper
    before_action :set_wallet

    def index
      @pagy, @transactions = pagy(@wallet.transactions.order(created_at: :desc))
      render json: {
        transactions: TransactionSerializer.new(@transactions).serializable_hash[:data].map{ |object| object[:attributes]},
        pagination: pagy_attributes(@pagy)
      }
    end

    def create
      @transaction = @wallet.transactions.new(
        **permitted_params,
        transaction_type: :credit,
        description: 'User deposited the amount in Kanz Bank Account'
      )
      if @transaction.save!
        render json: {
          transactions: TransactionSerializer.new(@wallet.transactions).serializable_hash[:data].map{ |object| object[:attributes]}
        }
      end
    end

    def create_payment_intent
      Stripe.api_key = ENV.fetch('STRIPE_SECRET')
      intent = Stripe::PaymentIntent.create({
                                              automatic_payment_methods: { enabled: true },
                                              amount: 1099,
                                              currency: 'usd'
                                            })
      success('success', { client_secret: intent.client_secret })
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