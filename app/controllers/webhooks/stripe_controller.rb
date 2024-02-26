# frozen_string_literal: true

module Webhooks
  class StripeController < ApplicationController
    skip_before_action :authenticate_admin_user!

    def create
      Rails.logger.debug params
    end
  end
end
