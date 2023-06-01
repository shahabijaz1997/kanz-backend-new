# frozen_string_literal: true

# Investor persona
module V1
  class UsersController < ApplicationController
    def show
      user_attributes = UserSerializer.new(current_user).serializable_hash[:data][:attributes]
      success(I18n.t('general.get_user'), user_attributes)
    end
  end
end
