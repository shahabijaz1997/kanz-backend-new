module ResponseHandler
  def success(message, data={})
    render json: {
      status: { 
        code: 200,
        message: message,
        data: data
      }
    }, status: :ok
  end

  def failure(message = 'Not Found', code = 400)
    render json: {
      status: { 
        code: code, 
        message: message
      }
    }, status: :bad_request
  end

  def unprocessable(message = 'Invalid Request')
    render json: {
      status: {
        code: 422,
        message: message
      }
    }, status: :unprocessable_entity
  end
end
