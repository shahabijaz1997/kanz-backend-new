# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApiController
    before_action :check_file_presence, only: %i[create]
    before_action :find_syndicate, only: %i[show]

    def index
      success(
        I18n.t('syndicate.get.success.show'),
        SyndicateSerializer.new(Syndicate.approved.all).serializable_hash[:data].map{ |sy| sy[:attributes] }
      )
    end

    def show
      success(
        I18n.t('syndicate.get.success.show'),
        SyndicateSerializer.new(@syndicate).serializable_hash[:data][:attributes]
      )
    end

    def create
      profile = current_user.profile || SyndicateProfile.new(syndicate_id: current_user.id)
      SyndicateProfile.transaction do
        profile.update!(profile_params.except(:logo))
        Attachment.upload_file(profile, profile_params[:logo]) if profile_params[:logo].present?
      end
      success(I18n.t('syndicate.update.success'))
    rescue StandardError => e
      failure(profile.errors.full_messages.to_sentence.presence || e.message)
    end

    private

    def profile_params
      return [] unless params[:syndicate_profile][:step].to_i.in?([1,2])

      if params[:syndicate_profile][:step].to_i == 1
        params.require(:syndicate_profile).permit(
          :step, :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link,
          :dealflow, region_ids: [], industry_ids: []
        )
      else
        params.require(:syndicate_profile).permit(:step, :name, :tagline, :logo)
      end
    end

    def check_file_presence
      return if current_user.profile&.attachment || params[:syndicate_profile][:step].to_i == 1

      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end

    def find_syndicate
      @syndicate = Syndicate.find_by(id: params[:id])
    end
  end
end
