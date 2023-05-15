# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do

    rescue_from ActionController::InvalidAuthenticityToken do |_e|
      render json: { message: 'You are not authorized' }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |_e|
      render json: { message: 'Record not found.' }, status: :not_found
    end

    rescue_from ActiveRecord::RecordNotUnique do |_e|
      render json: { message: 'Record already exists.' }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |_e|
      render json: { message: 'Unprocessable Entity, missing parameter.' }, status: :unprocessable_entity
    end

    rescue_from Pundit::NotAuthorizedError do |_e|
      render json: { message: 'You are not authorized to perform this action.' }, status: :forbidden
    end

    rescue_from ArgumentError do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

  end
end
