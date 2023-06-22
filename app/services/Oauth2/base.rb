# frozen_string_literal: true

module Oauth2
  class Base < ApplicationService
    attr_reader :token, :type, :provider, :errors

    def initialize(token, type)
      @token = token
      @type = type
      @errors = []
    end

    def auth_object(response)
      return if errors.any?

      Struct.new(:provider, :uid, :email, :name, :type).new(
        provider,
        response.with_indifferent_access['sub'] || SecureRandom.base64(10),
        response.with_indifferent_access['email'],
        response.with_indifferent_access['name'],
        type
      )
    end

    def user_with_errors
      user = User.new
      user.errors.add(:base, errors.first)
      user
    end
  end
end
