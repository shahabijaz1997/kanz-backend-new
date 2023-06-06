# frozen_string_literal: true

# Investor persona
module V1
  class InvestorsController < ApplicationController
    before_action :validate_persona

    def show
      investor_attributes = InvestorSerializer.new(@investor).serializable_hash[:data][:attributes]
      success(I18n.t('investor.get.success.show'), investor_attributes)
    end

    def set_role
      if @investor.update(role_id: role.id)
        success(I18n.t('investor.update.success.role', kind: investor_params[:role]))
      else
        failure(@investor.errors.full_messages.to_sentence)
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
      params.require(:investor_profile).permit(%i[legal_name country_id residence accreditation
                                                  accepted_investment_criteria])
    end

    def investor_params
      params.require(:investor).permit(:role)
    end

    def role
      Role.find_by(title: investor_params[:role])
    end
  end
end
