# frozen_string_literal: true

# Startups apis
module V1
  class StartupsController < ApplicationController
    before_action :validate_startup
    before_action :check_file_presence, only: %i[create]

    def show
      startup_attributes = StartupSerializer.new(@startup).serializable_hash[:data][:attributes]
      success(I18n.t('startup.get.success.show'), startup_attributes)
    end

    def create
      profile = @startup.profile || StartupProfile.new(startup_id: @startup.id)
      StartupProfile.transaction do
        profile.update!(profile_params.except(:logo))
        Attachment.upload_file(profile, profile_params[:logo]) if profile_params[:logo].present?
      end
      success(I18n.t('startup.update.success.comapny_info'))
    rescue StandardError => e
      failure(profile.errors.full_messages.to_sentence.presence || e.message)
    end

    private

    def profile_params
    end

    def validate_startup
      return unprocessable unless current_user.startup?

      @startup = current_user
    end

    def check_file_presence
      return if @startup.profile&.attachment || params[:startup_profile][:step].to_i == 1

      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end
  end
end
