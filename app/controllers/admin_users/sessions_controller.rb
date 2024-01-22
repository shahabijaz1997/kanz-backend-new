# frozen_string_literal: true

module AdminUsers
  class SessionsController < Devise::SessionsController
    def create
      resource = AdminUser.find_by(permitted_params)
      if resource&.deactivated? && resource.valid_password?(params[:user].dig(:password))
        flash[:alert] = I18n.t('devise.failure.is_deactivated')
        redirect_to root_path
      else
        super
      end
    end

    def permitted_params
      params.require(:admin_user).permit(:email)
    end
  end
end
