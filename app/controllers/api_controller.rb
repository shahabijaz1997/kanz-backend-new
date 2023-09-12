# frozen_string_literal: true

class ApiController < ActionController::API
  include ResponseHandler
  include Pundit
  include ExceptionHandler

  before_action :authenticate_user!
  before_action :block_unconfirmed_access
  before_action :set_locale
  respond_to :json

  def block_unconfirmed_access
    return if current_user.blank? || current_user.confirmed?

    failure(I18n.t('devise.failure.unconfirmed'), current_user)
  end

  def set_locale
    return unless current_user

    I18n.locale = current_user.arabic? ? :ar : :en
  end
end
