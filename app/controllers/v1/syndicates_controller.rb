# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApiController
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
      success(I18n.t('syndicate.update.success'))
    rescue StandardError => e
      failure(profile.errors.full_messages.to_sentence.presence || e.message)
    end

    private

    def validate_persona
      return unprocessable unless current_user.syndicate?

      @syndicate = current_user
    end

    def profile_params
      return [] unless params[:syndicate_profile][:step].to_i.in?([1,2])

      if params[:syndicate_profile][:step].to_i == 1
        params.require(:syndicate_profile).permit(
          :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link,
          :dealflow, region_ids: [], industry_ids: []
        )
      else
        params.require(:syndicate_profile).permit(:name, :tagline, :logo)
      end
    end

    def check_file_presence
      return if @syndicate.profile&.attachment || params[:syndicate_profile][:step].to_i == 1

      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end
  end
end
