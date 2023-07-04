# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApplicationController
    before_action :validate_persona
    before_action :check_file_presence, only: %i[create]

    def show
      user_attributes = SyndicateSerializer.new(@syndicate).serializable_hash[:data][:attributes]

      success(I18n.t('syndicate.get.success.show'), user_attributes)
    end

    def create
      profile = @syndicate.profile || SyndicateProfile.new(syndicate_id: @syndicate.id)

      SyndicateProfile.transaction do
        profile.update!(profile_params.except(:logo))
        Attachment.upload_file(profile, profile_params[:logo]) if profile_params[:logo].present?
      end
      success(I18n.t('syndicate.update.success.comapny_info'))
    rescue StandardError => e
      failure(profile.errors.full_messages.to_sentence.presence || e.message)
    end

    private

    def validate_persona
      return unprocessable unless current_user.syndicate?

      @syndicate = current_user
    end

    def profile_params
      params.require(:syndicate_profile).permit(
        :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link,
        :dealflow, :name, :tagline, :logo, region: [], industry_market: []
      )
    end

    def check_file_presence
      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end

    def check_file_presence
      return if @syndicate.profile.present? && @syndicate.profile.attachment.present?

      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end
  end
end
