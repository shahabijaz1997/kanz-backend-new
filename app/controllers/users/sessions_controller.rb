# frozen_string_literal: true

module Users
  # Devise sessions_controller
  class SessionsController < Devise::SessionsController
    include RackSessionSolution
    include ResponseHandler

    before_action :update_language
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      data = UserSerializer.new(resource).serializable_hash[:data][:attributes]

      success(I18n.t('devise.sessions.signed_in'), data)
    end

    def respond_to_on_destroy
      if current_user
        success(I18n.t('devise.sessions.signed_out'))
      else
        failure(I18n.t('devise.failure.unauthenticated'), 401)
      end
    end

    def update_language
      I18n.locale = params[:user][:language] == 'ar' ? :ar : :en
    end
  end
end
