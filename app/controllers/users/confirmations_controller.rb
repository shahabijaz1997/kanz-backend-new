# frozen_string_literal: true

class Users::ConfirmationsController < Devise::RegistrationsController

  include RackSessionSolution
  respond_to :json

   # POST /resource/confirmation
   def create
    self.resource = resource_class.send_confirmation_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  end

  # POST /resource/confirmation?confirmation_token=abcdef
  def confirm_account
    return unprocessable_request if params[:confirmation_token].blank?

    response = validate_confirmation_token(token)
    if response[:status]
      current_user.confirmed_at = Time.now.utc
      render json: {
        status: { code: 200, message: response[:message] },
      }, status: :ok
    else
      render json: {
        status: { code: 400, message: response[:message] }
      }, status: :not_found
    end
  end

  private

  def respond_with(resource, _opts = {})
    render json: {
      status: { code: 200, message: 'Logged in sucessfully.' },
      data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
    }, status: :ok
  end

  def unprocessable_request
    render json: {
      status: {
      code: 422,
      message: 'Invalid confirmation token'
      }
    }, status: :unprocessable_entity
  end
end
