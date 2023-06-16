module Google
  class Auth < ApplicationService
    attr_reader :access_token

    def intialize(access_token)
      access_token = access_token
    end

    def call
      response = get_profile
      
    end

    private

    def get_profile
      HTTParty.get(google_infoapi_url)
    end

    def google_infoapi_url
      "https://www.googleapis.com/oauth2/v3/userinfo?access_token=#{access_token}"
    end
  end
end
