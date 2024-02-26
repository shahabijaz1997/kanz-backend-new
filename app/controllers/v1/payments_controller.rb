# frozen_string_literal: true

require 'stripe'

module V1
  class PaymentsController < ApiController
    def payment_intent
      Stripe.api_key = ENV.fetch('STRIPE_SECRET')
      intent = Stripe::PaymentIntent.create(payment_intent_params)
      success('success', { client_secret: intent.client_secret })
    end

    private

    def payment_intent_params
      params.require(:payment).permit(%i[amount currency])
    end
  end
end
