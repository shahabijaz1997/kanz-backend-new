# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_user!
  respond_to :json
end
