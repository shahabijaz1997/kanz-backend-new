# frozen_string_literal: true
module V1
  class ProfilesController < ApiController
    before_action :set_user, only: %i[show update]

    def show
      success(I18n.t('general.get_user'), user_serializer.new(@user).serializable_hash[:data][:attributes])
    end

    def update
      @user.update(profile_params)
      if @user.errors.blank?
        success(I18n.t('general.get_user'), user_serializer.new(@user).serializable_hash[:data][:attributes])
      else
        failure('Failed', @user.errors.full_messages.join('<br>'))
      end
    end

    private

    def set_user
      @user = current_user
    end

    def user_serializer
      "#{current_user.type}Serializer".constantize
    end

    def profile_params
      params.require(:user).permit(permitted_params)
    end

    def permitted_params
      if current_user.investor?
        [:name, :profile_picture]
      elsif current_user.syndicate?
        [:name, :profile_picture, profile_attributes: [:name, :tagline, :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link, :dealflow, region_ids: [], industry_ids: []]]
      elsif current_user.fund_raiser?
        [:name, :profile_picture, profile_attributes: [:company_name, :legal_name, :website, :address, :description, :ceo_name, :ceo_email, :total_capital_raised, :current_round_capital_target, industry_ids: []]]
      end
    end
  end
end