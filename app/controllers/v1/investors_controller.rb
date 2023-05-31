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
        success(I18n.t('investor.update.success.role', kind: investor_params[:role]))
      else
        failure(current_user.errors.full_messages.to_sentence)
      end
    end

    def accreditation
      profile = @investor.profile || InvestorProfile.new(investor_id: @investor.id)

      if profile.update(accreditation_params)
        success(I18n.t('investor.update.success.accreditation'))
      else
        failure(profile.errors.full_messages.to_sentence)
      end
    end

    private

    def validate_persona
      unprocessable unless current_user.investor?

      @investor = current_user
    end

    def accreditation_params
      params.require(:investor_profile).permit(%i[country_id location residence accreditation
                                                  accepted_investment_criteria])
    end
  end
end
