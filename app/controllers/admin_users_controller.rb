class AdminUsersController < ApplicationController
  before_action :set_admin_user, only: %i[ show edit update destroy ]
  before_action :perform_authorization

  def index
    load_admin_roles
    @filtered_admin_users = AdminUser.ransack(params[:search])
    @admin_users = policy_scope(@filtered_admin_users.result(distinct: true).order(created_at: :desc))
  end

  def show
  end

  def new
    load_admin_roles
    @admin_user = AdminUser.new
  end

  def create
    load_admin_roles
    @admin_user = AdminUser.new(admin_user_params)
    respond_to do |format|
      if @admin_user.save!
        format.html { redirect_to admin_user_path(@admin_user), notice: "Admin User was successfully updated." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    load_admin_roles
  end

  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to admin_user_path(@admin_user), notice: "Admin User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
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
    @admin_roles.merge({
      'Super Admin': 1,
      'Admin': 2,
    }) if current_admin_user.super_admin?
  end
end
