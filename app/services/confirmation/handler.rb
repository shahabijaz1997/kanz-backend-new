# frozen_string_literal: true

module Confirmation
  class Handler < ApplicationService
    attr_reader :token, :user

    def initialize(user, token)
      @user = user
      @token = token
    end

    def call
      return already_confirmed if user.confirmed?
      return invalid_token unless valid_token?
      return expired_token if token_expired?
      return success if mark_confirmed

      failed_to_update
    end

    private

    def already_confirmed
      response(I18n.t('errors.messages.already_confirmed'), false)
    end

    def invalid_token
      response(I18n.t('general.invalid'), false)
    end

    def success
      response(I18n.t('devise.confirmations.confirmed'), true)
    end

    def failed_to_update
      response(user.errors.full_messages.to_sentence, false)
    end

    def expired_token
      response(I18n.t('general.token_expired'), false)
    end

    def valid_token?
      user.confirmation_token == token
    end

    def token_expired?
      return unless valid_token?

      ((Time.now.utc - user.confirmation_sent_at.utc) / 1.minute) > 15
    end

    def mark_confirmed
      user.update(confirmed_at: Time.zone.now, unconfirmed_email: nil)
    end
  end
end
