# frozen_string_literal: true

module Webhooks
  class StripeController < ApplicationController
    skip_before_action :authenticate_user!

    def create
      p params
    end
  end
end
