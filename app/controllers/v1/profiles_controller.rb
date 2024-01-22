# frozen_string_literal: true
module V1
  class ProfilesController < ApiController
    before_action :set_user, only: %i[show update]

    def show
      success(
        I18n.t('general.get_user'),
        UserSerializer.new(@user).serializable_hash[:data][:attributes]
      )
    end

    def update
      @user.update(profile_params)
      if @user.errors.blank?
        success(
          I18n.t('general.get_user'),
          UserSerializer.new(@user).serializable_hash[:data][:attributes]
        )
      else
        flash[:alert] = @user.errors.full_messages.join('<br>')
        format.html { redirect_to edit_profile_path }
      end
    end

    private

    def set_user
      @user = current_user
    end

    def profile_params
      params.require(:user).permit(permitted_params)
    end

    def permitted_params
      if current_user.investor?
        [:name]
      elsif current_user.syndicate?
        [:name]
      elsif current_user.fund_raiser?
        [:name]
      end
    end
  end
end