# frozen_string_literal: true

require 'stripe'

module V1
  class PaymentsController < ApiController
    def payment_intent
      Stripe.api_key = ENV.fetch('STRIPE_SECRET')
      intent = Stripe::PaymentIntent.create(
        {
          amount: payment_intent_params[:amount],
          currency: payment_intent_params[:currency]
        }
      )
      success('success', { client_secret: intent.client_secret })
    end

    private

    def payment_intent_params
      params.require(:payment).permit(:amount, :currency)
    end
  end
end
