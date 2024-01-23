# frozen_string_literal: true

class AdminUsersController < ApplicationController
  before_action :set_admin_user, only: %i[show edit update destroy reactivate]
  before_action :load_admin_roles, only: %i[index new edit create]
  before_action :authorize_role!

  def index
    @filtered_admin_users = AdminUser.ransack(params[:search])
    @pagy, @admin_users = pagy(policy_scope(@filtered_admin_users.result(distinct: true).order(created_at: :desc)))
  end

  def show; end

  def new
    @admin_user = flash[:admin_user] ? AdminUser.new(flash[:admin_user]) : AdminUser.new
  end

  def edit; end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    respond_to do |format|
      if @admin_user.save
        format.html { redirect_to admin_user_path(@admin_user), notice: 'Successfully updated.' }
      else
        flash[:alert] = @admin_user.errors.full_messages.join('<br>')
        flash[:admin_user] = @admin_user
        format.html { redirect_to new_admin_user_path }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to admin_user_path(@admin_user), notice: 'Successfully updated.' }
      else
        flash[:alert] = @admin_user.errors.full_messages.join('<br>')
        format.html { redirect_to edit_admin_user_path(@admin_user) }
      end
    end
  end

  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to @admin_user, notice: 'Admin Deactivated.' }
    end
  end

  def reactivate
    @admin_user.reactivate
    respond_to do |format|
      format.html { redirect_to @admin_user, notice: 'Admin Reactivated.' }
    end
  end

  private

  def set_admin_user
    @admin_user = policy_scope(AdminUser).find(params[:id])
  end

  def admin_user_params
    params.require(:admin_user).permit(:email, :first_name, :last_name, :admin_role_id, :password, :password_confirmation)
  end

  def load_admin_roles
    @admin_roles = {
      'Customer Support Rep': 3,
      'Compliance Officer': 4
    }
    return unless current_admin_user.super_admin?

    @admin_roles = @admin_roles.merge({ 'Super Admin': 1, Admin: 2 })
  end
end
