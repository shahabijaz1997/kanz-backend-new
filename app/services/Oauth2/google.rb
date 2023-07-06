module Oauth2
  class Google < Base
    def initialize(token, type, language)
      super
      @provider = 'Google'
    end

    def call
      auth = auth_object(profile)
      return user_with_errors if errors.any?

      User.from_social_auth(auth)
    end

    private

    def profile
      response = HTTParty.get(google_infoapi_url)
      errors << I18n.t('auth.profile_failure') unless response.code.in?([200, 201])
      response
    end

    def google_infoapi_url
      "https://www.googleapis.com/oauth2/v3/userinfo?access_token=#{token}"
    end
  end
end
