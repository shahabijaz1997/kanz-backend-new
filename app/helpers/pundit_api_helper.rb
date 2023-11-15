# frozen_string_literal: true

module PunditApiHelper
  def pundit_user
    current_user
  end

  def user_not_authorized
    failure(I18n.t('errors.exceptions.unauthorized'), 401)
  end

  def perform_authorization
    authorize current_user
  end
end
