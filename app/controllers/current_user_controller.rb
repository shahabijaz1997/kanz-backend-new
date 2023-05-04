# frozen_string_literal: true

# For returning current_user, useful with front-end app
class CurrentUserController < ApplicationController
  before_action :authenticate_user!
  def index
    render json: current_user, status: :ok
  end
end
