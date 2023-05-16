# frozen_string_literal: true

module Users
  # Devise Registration
  class RegistrationsController < Devise::RegistrationsController
    include RackSessionSolution
    include ResponseHandler

    respond_to :json

    private

    def respond_with(resource, _opts = {})
      return success('Account deleted successfully.') if request.method == 'DELETE'

      if request.method == 'POST' && resource.persisted?
        data = UserSerializer.new(resource).serializable_hash[:data][:attributes]
        success('Signed up sucessfully.', data)
      else
        unprocessable("User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}")
      end
    end
  end
end
