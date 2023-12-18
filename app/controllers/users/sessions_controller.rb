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
      if resource.persisted?
        I18n.locale = resource.arabic? ? :ar : :en
        success(I18n.t('devise.sessions.signed_in'), data)
      else
        failure(I18n.t('auth.invalid'), 401)
      end
    end

    def respond_to_on_destroy
      update_language
      if current_user.blank?
        success(I18n.t('devise.sessions.signed_out'))
      else
        failure(I18n.t('devise.failure.unable_to_signout'), 401)
      end
    end

    def update_language
      return if params[:user].blank? || params[:user][:language].blank?

      I18n.locale = params[:user][:language] == 'ar' ? :ar : :en
    end
  end
end
