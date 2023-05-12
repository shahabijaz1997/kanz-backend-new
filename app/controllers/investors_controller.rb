# frozen_string_literal: true

# Investor persona
class InvestorsController < ApplicationController
  def show
    user_attributes = UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    success_response('', user_attributes)
  end

  def set_role
    current_user.role = investor_params[:type]
    if current_user.save
      success_response('Successfully update the investor type')
    else
      failure_reponse(current_user.errors.full_messages.to_sentence)
    end
  end

  def accreditation
    return unprocessable_request unless current_user.investor?

    current_user.meta_info = current_user.individual_investor? ? investor_meta_info : firm_meta_info
    if current_user.save
      success_response('Successfuly updated accreditation info.')
    else
      failure_reponse(current_user.errors.full_messages.to_sentence)
    end
  end

  def philosophy_question
    questions = Question.where(step: current_step)
    data = QuestionSerializer.new(questions).serializable_hash[:data].map{ |data| data[:attributes] }
    success_response("Questions for step: #{current_step}", data)
  end

  def philosophy

  end

  private

  def investor_params
    params.require(:investor).permit(:type)
  end

  def investor_accredation_params
    params.require(:investor).permit(
      meta_info: %i[
        nationality residence accredititation lower_limit uper_limit accept_investment_criteria
      ]
    )
  end

  def firm_accredation_params
    params.require(:investor).permit(
      meta_info: %i[
        legal_name location accredititation lower_limit uper_limit accept_investment_criteria
      ]
    )
  end

  def investor_meta_info
    investor_accredation_params[:meta_info]
  end

  def firm_meta_info
    firm_accredation_params[:meta_info]
  end

  def current_step
    params[:step].to_i
  end

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
        message:
      }
    }, status: :unprocessable_entity
  end
end
