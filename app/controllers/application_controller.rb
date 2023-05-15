# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!
  respond_to :json

  def success_response(message, data={})
    render json: {
      status: { code: 200, message: message, data: data}
    }, status: :ok
  end

  def failure_reponse(message = 'Not Found')
    render json: {
      status: {
        code: 400,
        message:
      }
    }, status: :unprocessable_entity
  end

  def unprocessable_request(message = 'Invalid Request')
    render json: {
      status: {
        code: 422,
        message: message
      }
    }, status: :unprocessable_entity
  end
end
