module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    include RackSessionSolution

    def linkedin
      omniauth_signin
    end

    def google_oauth2
      omniauth_signin
    end

    private

    def omniauth_signin
      user = User.from_omniauth(auth)

      if user.present?
        signin_and_respond(user)
      else
        failure(I18n.t('devise.omniauth_callbacks.failure'))
      end
    end

    def auth
      @auth ||= request.env['omniauth.auth']
    end

    def signin_and_respond
      sign_in(User, user)
      data = UserSerializer.new(user).serializable_hash[:data][:attributes]
      success(I18n.t('devise.sessions.signed_in'), data)
    end
  end
end
