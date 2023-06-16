require 'httparty'

module Users
  class SocialAuthController < ApplicationController
    include RackSessionSolution
    include HTTParty
    skip_before_action :authenticate_user!

    def google
      response = get_google_profile
      auth_object = auth('google', response, params[:type])
      user = User.from_social_auth(auth_object)
      if user.present?
        signin_and_respond(user)
      else
        failure(I18n.t('devise.omniauth_callbacks.failure'))
      end
    end 

    def linkedin
      debugger
    end

    private

    def auth(provider, response, type)
      Struct.new(:provider, :uid, :email, :name, :type).new(
        provider,
        response['sub'],
        response['email'],
        response['name'],
        type
      )
    end

    def signin_and_respond(user)
      sign_in(User, user)
      data = UserSerializer.new(user).serializable_hash[:data][:attributes]
      success(I18n.t('devise.sessions.signed_in'), data)
    end

    def get_google_profile
      access_token = params[:access_token]
      url = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=#{access_token}"      
      HTTParty.get(url)
    end
  end
end
