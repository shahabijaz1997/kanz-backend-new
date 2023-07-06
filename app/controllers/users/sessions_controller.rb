# frozen_string_literal: true

module Users
  # Devise sessions_controller
  class SessionsController < Devise::SessionsController
    include RackSessionSolution
    include ResponseHandler

    respond_to :json

    private

    def respond_with(resource, _opts = {})
      data = UserSerializer.new(resource).serializable_hash[:data][:attributes]

      success(I18n.t('devise.sessions.signed_in'), data, 'signed_in')
    end

    def respond_to_on_destroy
      if current_user
        success(I18n.t('devise.sessions.signed_out'))
      else
        failure(I18n.t('devise.failure.unauthenticated'), 401)
      end
    end
  end
end
