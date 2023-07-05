# frozen_string_literal: true

class ApiController < ActionController::API
  include ResponseHandler
  include Pundit
  include ExceptionHandler

  before_action :authenticate_user!
  before_action :set_locale
  respond_to :json

  def set_locale
    return unless current_user
    I18n.locale = :ar if current_user.arabic?
  end
end
