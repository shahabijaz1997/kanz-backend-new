# frozen_string_literal: true

module Oauth2
  class LinkedIn < Base
    PROFILE_URL = 'https://api.linkedin.com/v2/me'
    EMAIL_URL = 'https://api.linkedin.com/v2/emailAddress?q=members&projection=(elements*(handle~))'
    ACCESS_TOKEN_URL = 'https://www.linkedin.com/oauth/v2/accessToken'

    def initialize(token, type, language)
      super
      @provider = 'LinkedIn'
    end

    def call
      auth_object = auth_object(profile)
      return user_with_errors if errors.any?

      User.from_social_auth(auth_object)
    end

    private

    def profile
      headers = auth_headers
      profile = lite_profile(headers)
      email = email(headers)
      return if errors.any?

      profile.merge(email)
    end

    def auth_headers
      access_token = get_access_token
      { Authorization: "Bearer #{access_token}" }
    end

    def get_access_token
      response = HTTParty.get(access_token_url)
      errors << I18n.t('auth.access_token_failure') and return unless response.code.in?([200, 201])

      response['access_token']
    end

    def access_token_url
      "#{ACCESS_TOKEN_URL}?#{query_params}"
    end

    def query_params
      {
        grant_type: 'authorization_code',
        code: token,
        redirect_uri: ENV.fetch('LINKEDIN_REDIRECT_URI', 'https://glacial-beach-24842.herokuapp.com/linkedin'),
        client_id: ENV.fetch('LINKEDIN_KEY', nil),
        client_secret: ENV.fetch('LINKEDIN_SECRET', nil)
      }.to_query
    end

    def lite_profile(headers)
      return if errors.any?

      response = HTTParty.get(PROFILE_URL, headers:)
      if response.try(:[], 'localizedFirstName')
        { name: "#{response['localizedFirstName']} #{response['localizedLastName']}" }
      else
        errors << I18n.t('auth.profile_failure')
      end
    end

    def email(headers)
      return if errors.any?

      response = HTTParty.get(EMAIL_URL, headers:)
      elements = response.try(:[], 'elements')
      return errors << I18n.t('auth.profile_failure') if elements.nil? || elements.blank?

      { email: elements.first['handle~']['emailAddress'] }
    end
  end
end
