# frozen_string_literal: true

module Users
  class SocialAuthController < ApiController
    include RackSessionSolution
    include HTTParty
    skip_before_action :authenticate_user!

    def google
      user = Oauth2::Google.call(params[:access_token], params[:type])
      respond(user)
    end

    def linkedin
      user = Oauth2::LinkedIn.call(params[:code], params[:type])
      respond(user)
    end

    private

    def respond(user)
      return failure(user.errors.full_messages.to_sentence) unless user.persisted?

      sign_in(User, user)
      success(I18n.t('devise.sessions.signed_in'), user.serialized_data)
    end
  end
end
