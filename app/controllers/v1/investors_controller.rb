# frozen_string_literal: true

# Investor persona
class V1::InvestorsController < ApplicationController
  def show
    user_attributes = UserSerializer.new(current_user).serializable_hash[:data][:attributes]
    success('', user_attributes)
  end

  def set_role
    current_user.role = investor_params[:type]
    if current_user.save
      success('Successfully update the investor type')
    else
      failure(current_user.errors.full_messages.to_sentence)
    end
  end

  def accreditation
    return unprocessable unless current_user.investor?

    current_user.meta_info = current_user.individual_investor? ? investor_meta_info : firm_meta_info
    if current_user.save
      success('Successfuly updated accreditation info.')
    else
      failure(current_user.errors.full_messages.to_sentence)
    end
  end

  private

  def investor_params
    params.require(:investor).permit(:type)
  end

  def investor_accredation_params
    params.require(:investor).permit(
      meta_info: %i[
        nationality residence accredititation lower_limit uper_limit accept_investment_criteria
    ])
  end

  def firm_accredation_params
    params.require(:investor).permit(
      meta_info: %i[
        legal_name location accredititation lower_limit uper_limit accept_investment_criteria
    ])
  end

  def investor_meta_info
    investor_accredation_params[:meta_info]
  end

  def firm_meta_info
    firm_accredation_params[:meta_info]
  end
end
