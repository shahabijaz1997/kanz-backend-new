# frozen_string_literal: true

module Users
  class SocialAuthController < ApplicationController
    include RackSessionSolution
    include HTTParty
    skip_before_action :authenticate_user!
    before_action :update_language

    def google
      user = Oauth2::Google.call(params[:access_token], params[:type], params[:language])
      respond(user)
    end

    def linkedin
      user = Oauth2::LinkedIn.call(params[:code], params[:type], params[:language])
      respond(user)
    end

    private

    def respond(user)
      return failure(user.errors.full_messages.to_sentence) unless user.persisted?
      I18n.locale = user.arabic? ? :ar : :en
      sign_in(User, user)
      success(I18n.t('devise.sessions.signed_in'), user.serialized_data)
    end

    def update_language
      I18n.locale = params[:language] == 'ar' ? :ar : :en
    end
  end
end
