class AdminUsers::RegistrationsController < Devise::RegistrationsController

  def create
    ActiveRecord::Base.transaction do
      create_user
    end
  end

  protected

  def create_user
    resource = build_resource(user_params)
    if resource.save
      profile = resource.create_profile(profile_params)
      profile.role = Tourist.create(name: 'Tourist')
      sign_in @user
      render json: {
        status: 'success',
        message: 'User registered successfully',
        data: resource
      },
      status: :ok
    else
      render json: {
        status: 'error',
        message: 'Registration failed',
        data: resource.errors
      },
      status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation
    )
  end

  def profile_params
    params.require(:user).permit(
      :first_name,
      :last_name
    )
  end
end
