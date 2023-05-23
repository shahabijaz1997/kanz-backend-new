# frozen_string_literal: true

# Investor persona
module V1
  class InvestorsController < ApplicationController
    before_action :validate_persona

    def show
      user_attributes = UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      success(I18n.t('investor.get.success.show'), user_attributes)
    end

    def set_role
      if current_user.update(investor_params)
        success(I18n.t('investor.update.success.role', kind: investor_params[:type]))
      else
        failure(current_user.errors.full_messages.to_sentence)
      end
    end

    def accreditation
      current_user.meta_info = current_user.individual_investor? ? investor_meta_info : firm_meta_info
      if current_user.save
        success(I18n.t('investor.update.success.accreditation'))
      else
        failure(current_user.errors.full_messages.to_sentence)
      end
    end

    private

    def validate_persona
      unprocessable unless current_user.investor?
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

    def investor_params
      params.require(:investor).permit(:type)
    end

    def investor_meta_info
      investor_accredation_params[:meta_info]
    end

    def firm_meta_info
      firm_accredation_params[:meta_info]
    end
  end
end
