# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include PunditHelper
  include ActiveStorage::SetCurrent
  include Pagy::Backend

  protect_from_forgery with: :null_session
  before_action :authenticate_admin_user!
  before_action :set_locale

  alias user_context pundit_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :user_not_authorized

  def authorize_role!
    policy_name = controller_name.camelize.singularize
    authorize policy_name.constantize
  end

  def block_unconfirmed_access
    return if current_user.blank? || current_user.confirmed?

    failure(I18n.t('devise.failure.unconfirmed'), current_user)
  end

  def set_locale
    I18n.locale = :en
  end
end
