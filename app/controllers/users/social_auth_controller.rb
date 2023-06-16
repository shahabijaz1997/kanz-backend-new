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
      if user.persisted?
        signin_and_respond(user)
      else
        failure(I18n.t('devise.omniauth_callbacks.failure'))
      end
    end 

    def linkedin
      headers = { Authorization: "Bearer #{get_access_token}" }
      profile = profile(headers)
      profile.merge!(email(headers))
      auth_object = auth('linkedin', profile, params[:type])

      user = User.from_social_auth(auth_object)
      if user.persisted?
        signin_and_respond(user)
      else
        failure(I18n.t('devise.omniauth_callbacks.failure'))
      end
    end

    private

    def auth(provider, response, type = 'Investor')
      Struct.new(:provider, :uid, :email, :name, :type).new(
        provider,
        response.with_indifferent_access['sub'],
        response.with_indifferent_access['email'],
        response.with_indifferent_access['name'],
        type
      )
    end

    def signin_and_respond(user)
      sign_in(User, user)
      data = UserSerializer.new(user).serializable_hash[:data][:attributes]
      success(I18n.t('devise.sessions.signed_in'), data)
    end

    # Google
    def get_google_profile
      access_token = params[:access_token]
      url = "https://www.googleapis.com/oauth2/v3/userinfo?access_token=#{access_token}"
      HTTParty.get(url)
    end

    # Linkedin
    def get_access_token
      q = {
        grant_type: "authorization_code",
        code: params[:code],
        redirect_uri: 'http://localhost:3001/users/social_auth/linkedin',
        client_id: ENV['LINKEDIN_KEY'],
        client_secret: ENV['LINKEDIN_SECRET']
      }.to_query

      url = "https://www.linkedin.com/oauth/v2/accessToken?#{q}"
      response = HTTParty.get(url)
      response["access_token"]
    end

    def profile(headers)
      profile_link = "https://api.linkedin.com/v2/me"
      response = HTTParty.get(profile_link, headers: headers)
      name = "#{response['localizedFirstName']} #{response['localizedLastName']}"
      {name: name}
    end

    def email(headers)
      email_link= "https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))"
      response = HTTParty.get(email_link, headers: headers)
      { email: response["elements"][0]["handle~"]["emailAddress"]}
    end
  end
end
