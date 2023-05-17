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

      if resource.errors.empty?
        sign_in(resource_name, resource)
        success('Account confirmed!')
      else
        unprocessable(resource.errors)
      end
    end

    # POST /resource/confirmation
    def create
      self.resource = resource_class.send_confirmation_instructions(resource_params)
      yield resource if block_given?

      if successfully_sent?(resource)
        success('New token is on its way!')
      else
        unprocessable
      end
    end
  end
end
