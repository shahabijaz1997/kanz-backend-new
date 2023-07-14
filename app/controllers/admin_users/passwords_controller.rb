# frozen_string_literal: true

module AdminUsers
  class PasswordsController < Devise::PasswordsController
    # GET /resource/password/edit?reset_password_token=abcdef
    def create
      resource = AdminUser.find_by(permitted_params)
      if resource&.deactivated?
        flash[:alert] = I18n.t('devise.failure.is_deactivated')
        redirect_to root_path
      else
        super
      end
    end

    def update
      self.resource = resource_class.reset_password_by_token(params[resource_name])
      respond_to do |format|
        if resource.errors.empty?
          flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
          set_flash_message(:notice, flash_message) if is_navigational_format?
          sign_in(resource_name, resource)
          format.html { respond_with resource, location: root_path }
        else
          flash[:alert] = resource.errors.full_messages.join('<br>')
          format.html { redirect_to edit_admin_user_password_path(reset_password_token: params[:admin_user][:reset_password_token]) }
        end
      end
    end

    def permitted_params
      params.require(:admin_user).permit(:email)
    end
  end
end
