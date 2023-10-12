# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::InvalidAuthenticityToken do |_e|
      render json: { message: I18n.t('errors.exceptions.auth_token_expired') }, status: :unauthorized
    end

    rescue_from ActiveRecord::RecordNotFound do |_e|
      render json: { message: I18n.t('errors.exceptions.not_found') }, status: :not_found
    end

    rescue_from ActiveRecord::RecordNotUnique do |_e|
      render json: { message: I18n.t('errors.exceptions.existing_record') }, status: :unprocessable_entity
    end

    rescue_from ActionController::ParameterMissing do |_e|
      render json: { message: I18n.t('errors.exceptions.paramete_missing') }, status: :unprocessable_entity
    end

    rescue_from Pundit::NotAuthorizedError do |_e|
      render json: { message: I18n.t('errors.exceptions.unauthorized') }, status: :forbidden
    end

    rescue_from ArgumentError do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end

    rescue_from StandardError do |e|
      Rails.logger.error ([e.message]+e.backtrace).join($/)
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end
