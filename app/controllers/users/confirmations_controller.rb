# frozen_string_literal: true

module Users
  class ConfirmationsController < ApiController
    include RackSessionSolution

    skip_before_action :authenticate_user!
    before_action :find_user, :validate_access_locked
    before_action :update_language

    def update
      response = Confirmation::Handler.call(@user, params[:confirmation_token])
      if response.status
        @user.update_profile_state
        signin_and_respond
      else
        @user.increment_failed_attempts
        return unprocessable(response.message) unless @user.attempts_exceeded?

        @user.lock_access!({ send_instructions: false })
        failure(I18n.t('devise.failure.locked'), 400, { account_status: 'blocked' })
      end
    end

    # POST /resource/confirmation
    def create
      return failure(I18n.t('errors.messages.already_confirmed')) if @user.confirmed?

      @user.send_confirmation_instructions
      success(I18n.t('devise.confirmations.resent_instruction'))
    end

    private

    def find_user
      @user = User.find_by(id: params[:id])
      @user = @user || User.find_by(resource_params) if params[:user].present?
      return failure(I18n.t('errors.exceptions.not_found')) if @user.blank?
    end

    def validate_access_locked
      failure(I18n.t('devise.failure.locked')) if @user.access_locked?
    end

    def resource_params
      params.require(:user).permit(:email)
    end

    def signin_and_respond
      sign_in(User, @user)
      data = UserSerializer.new(@user).serializable_hash[:data][:attributes]
      success(I18n.t('devise.confirmations.confirmed'), data)
    end

    def update_language
      I18n.locale = @user.arabic? ? :ar : :en
    end
  end
end
