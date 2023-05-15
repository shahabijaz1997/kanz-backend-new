# frozen_string_literal: true

class ApplicationController < ActionController::API

  include Pundit
  include ExceptionHandler

  before_action :authenticate_user!
  respond_to :json

end
