class InvestorsController < ApplicationController
  def set_role
    current_user.role = investor_params[:type]
    if current_user.save
      success_response('Successfully update the investor type')
    else
      failure_reponse(current_user.errors.full_messages.to_sentence)
    end
  end

  def accreditation

  end

  private

  def investor_params
    params.require(:investor).permit(:type)
  end

  def accredation_params
    params.require(:investor_accredation).permit(:nationality, :residence, :legal_name, :location)
  end

  def success_response(message)
    render json: {
      status: { code: 200, message: message },
    }, status: :ok
  end

  def failure_reponse(message = 'Not Found')
    render json: {
      status: {
        code: 400,
        message: message
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
