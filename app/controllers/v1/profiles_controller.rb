# frozen_string_literal: true
module V1
  class ProfilesController < ApiController
    before_action :set_profile, only: %i[show update]

    def show
      success(I18n.t('general.get_user'), user_serializer.new(current_user).serializable_hash[:data][:attributes])
    end

    def update
      @profile.update(profile_params)
      if @profile.errors.blank?
        success(I18n.t('general.get_user'), user_serializer.new(current_user).serializable_hash[:data][:attributes])
      else
        failure('Failed', @profile.errors.full_messages.join('<br>'))
      end
    end

    private

    def set_profile
      @profile = current_user.profile
    end

    def user_serializer
      "#{current_user.type}Serializer".constantize
    end

    def profile_params
      params.require(:profile).permit(permitted_params)
    end

    def permitted_params
      if current_user.investor?
        [investor_attributes: [:name, :profile_picture]]
      elsif current_user.syndicate?
        [:name, :tagline, :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link, :dealflow, region_ids: [], industry_ids: [], syndicate_attributes: [:name, :profile_picture]]
      elsif current_user.fund_raiser?
        [:company_name, :legal_name, :website, :address, :description, :ceo_name, :ceo_email, :total_capital_raised, :current_round_capital_target, industry_ids: [], fund_raiser_attributes: [:name, :profile_picture]]
      end
    end
  end
end