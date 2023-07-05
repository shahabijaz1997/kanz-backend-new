class AdminUsers::RegistrationsController < Devise::RegistrationsController

  prepend_before_action :require_no_authentication, only: [:create]
  
  skip_before_action :verify_authenticity_token

  before_action :ensure_params_exist, only: [:create]

  def create
    resource = ::User.find_by(email: params[:email])

    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:password])
      sign_in("user", resource)
      @profile = resource.profile
    end
    
    invalid_login_attempt unless @profile

    render json: {
      user: {
        first_name: @profile.first_name,
        last_name: @profile.last_name,
        email: current_user.email,
        currency: @profile.currency
      }
    }, status: 200
  end

  def check_session
    @profile = current_user.profile if current_user
  end

  def destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    render json: {:success => true, auth_token: nil }.to_json
  end

  protected

  def ensure_params_exist
    return unless params[:email].blank?
    render(json: { error: { message: "missing email parameter" }}, status: 422) and return
    return unless params[:password].blank?
    render(json: { error: { message: "missing password parameter" }}, status: 422) and return
  end

  def invalid_login_attempt
    warden.custom_failure!
    # render(json: { error: { message: "Error with your login or password" }}, status: 422)
    render json: { message: "Error with your login or password" }, status: :not_found
  end

  private

  def create_params
    params.permit(:email, :password)
  end

end
