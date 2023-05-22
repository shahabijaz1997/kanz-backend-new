# frozen_string_literal: true

# Investor persona
class V1::InvestorsController < ApplicationController
  before_action :validate_persona

  def show
    user_attributes = InvestorSerializer.new(current_user).serializable_hash[:data][:attributes]
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
    current_user.meta_info = current_user.individual_investor? ? investor_meta_info : firm_meta_info
    if current_user.save
      success('Successfuly updated accreditation info.')
    else
      failure(current_user.errors.full_messages.to_sentence)
    end
  end

  private

  def validate_persona
    unprocessable unless current_user.investor?
  end

  def investor_params
    params.require(:investor).permit(:type)
  end

  def investor_accredation_params
    params.require(:investor).permit(
      meta_info: [
        :nationality, :residence, :accept_investment_criteria, accreditation: %i[statement lower_limit uper_limit unit currency]
    ])
  end

  def firm_accredation_params
    params.require(:investor).permit(
      meta_info: [
        :legal_name, :location, :accept_investment_criteria, accreditation: %i[statement lower_limit uper_limit unit currency]
    ])
  end

  def investor_meta_info
    investor_accredation_params[:meta_info]
  end

  def firm_meta_info
    firm_accredation_params[:meta_info]
  end
end
