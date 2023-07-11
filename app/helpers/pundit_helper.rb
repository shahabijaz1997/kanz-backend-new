# frozen_string_literal: true

module PunditHelper
  def pundit_user
    current_admin_user
  end

  def user_not_authorized
    flash[:notice] = 'You are not authorized to perform this action.'
    redirect_to(request.referer || root_path)
  end

  def perform_authorization
    authorize current_admin_user
  end
end
