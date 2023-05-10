# frozen_string_literal: true

# For returning current_user, useful with front-end app
class CurrentUserController < ApplicationController
  def index
    render json: current_user, status: :ok
  end
end
