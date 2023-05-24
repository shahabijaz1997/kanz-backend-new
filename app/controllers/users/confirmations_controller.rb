# frozen_string_literal: true

module Users
  class ConfirmationsController < Devise::ConfirmationsController
    include RackSessionSolution
    include ResponseHandler

    respond_to :json

    # POST /resource/confirmation?confirmation_token=abcdef
    def show
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?

      return unprocessable(resource.errors) if resource.errors.present?

      signin_and_respond
    end

    # POST /resource/confirmation
    def create
      self.resource = resource_class.send_confirmation_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        success(I18n.t('devise.confirmations.resent_instruction'))
      else
        unprocessable
      end
    end

    private

    def signin_and_respond
      sign_in(resource_name, resource)
      data = UserSerializer.new(resource).serializable_hash[:data][:attributes]
      success(I18n.t('devise.confirmations.confirmed'), data)
    end
  end
end
