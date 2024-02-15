# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :set_admin_user, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    @admin_user.update(profile_params)
    update_password if @admin_user.errors.blank?
    respond_to do |format|
      if @admin_user.errors.blank?
        format.html { redirect_to profile_path, notice: @notice || 'Successfully updated.' }
      else
        flash[:alert] = @admin_user.errors.full_messages.join('<br>')
        format.html { redirect_to edit_profile_path }
      end
    end
  end

  private

  def set_admin_user
    @admin_user = current_admin_user
  end

  def profile_params
    params.require(:admin_user).permit(:email, :first_name, :last_name)
  end

  def update_password
    permitted_params = params.require(:admin_user).permit(:password, :password_confirmation)
    return if permitted_params[:password].blank? && permitted_params[:password_confirmation].blank?

    @admin_user.update(permitted_params)
    @notice = 'Password successfully updated, please login again.'
  end
end
