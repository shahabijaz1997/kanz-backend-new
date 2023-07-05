# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include Pundit::Authorization
  include ActiveStorage::SetCurrent
  before_action :authenticate_admin_user!

end
