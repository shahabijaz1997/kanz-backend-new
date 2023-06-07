# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApplicationController
    before_action :validate_persona

    def show
      user_attributes = SyndicateSerializer.new(@syndicate).serializable_hash[:data][:attributes]

      success(I18n.t('syndicate.get.success.show'), user_attributes)
    end

    def create
      profile = @syndicate.profile || SyndicateProfile.new(syndicate_id: @syndicate.id)

      SyndicateProfile.transaction do
        logo_url = Attachment.upload_file(profile, syndicate_profile_params[:logo])
        profile.update!(syndicate_profile_params.merge(logo: logo_url))
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

    def syndicate_profile_params
      params.require(:syndicate_profile).permit(
        :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link,
        :dealflow, :name, :tagline, :logo, region: [], industry_market: []
      )
    end
  end
end
