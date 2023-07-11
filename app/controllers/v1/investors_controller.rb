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
        update_investor_state
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
      params.require(:investor_profile).permit(%i[legal_name country_id accreditation_option_id
                                                  residence_id accepted_investment_criteria])
    end

    def investor_params
      params.require(:investor).permit(:role)
    end

    def role
      Role.find_by(title: investor_params[:role])
    end

    def update_investor_state
      profile_states = @investor.profile_states
      profile_states[:investor_type] = @investor.role_title
      @investor.update(profile_states: profile_states)
    end
  end
end
