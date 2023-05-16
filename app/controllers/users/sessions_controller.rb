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
      success('Logged in sucessfully.', data)
    end

    def respond_to_on_destroy
      if current_user
        success('logged out successfully')
      else
        failure("Couldn't find an active session.", 401)
      end
    end
  end
end
