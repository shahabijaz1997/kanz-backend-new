# frozen_string_literal: true

class ApiController < ActionController::API
  include ResponseHandler
  include Pundit::Authorization
  include PunditApiHelper
  include ExceptionHandler

  before_action :authenticate_user!
  before_action :block_unconfirmed_access
  before_action :set_locale
  respond_to :json

  alias user_context pundit_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def block_unconfirmed_access
    return if current_user.blank? || current_user.confirmed?

    failure(I18n.t('devise.failure.unconfirmed'), current_user)
  end

  def set_locale
    return unless current_user

    I18n.locale = current_user.arabic? ? :ar : :en
  end

  def authorize_role!
    policy_name = controller_name.camelize.singularize
    authorize policy_name.constantize
  end
end
