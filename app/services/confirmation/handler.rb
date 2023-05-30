# frozen_string_literal: true

module Confirmation
  class Handler < ApplicationService
    attr_reader :token, :user, :response

    def initialize(user, token)
      @user = user
      @token = token
      @response = Struct.new(:status, :message)
    end

    def call
      return already_confirmed if user.confirmed?
      return invalid_token unless valid_token?
      return success if mark_confirmed

      failed_to_update
    end

    private

    def already_confirmed
      response.new(false, I18n.t('errors.messages.already_confirmed'))
    end

    def invalid_token
      response.new(false, I18n.t('general.invalid'))
    end

    def success
      response.new(true, I18n.t('devise.confirmations.confirmed'))
    end

    def failed_to_update
      response.new(false, user.errors.full_messages.to_sentence)
    end

    def valid_token?
      user.confirmation_token == token
    end

    def mark_confirmed
      user.update(confirmed_at: Time.zone.now, unconfirmed_email: nil)
    end
  end
end
