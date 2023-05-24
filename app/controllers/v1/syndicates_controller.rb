# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApplicationController
    before_action :validate_persona

    def show
      user_attributes = SyndicateSerializer.new(
        @syndicate, include: ['syndicate_profile']
      ).serializable_hash[:data]

      success(I18n.t('syndicate.get.success.show'), user_attributes)
    end

    def create
      profile = @syndicate.profile || SyndicateProfile.new(syndicate_id: @syndicate.id)

      if syndicate_profile.update(syndicate_profile_params)
        success(I18n.t('syndicate.update.success.profile'))
      else
        failure(syndicate_profile.errors.full_messages.to_sentence)
      end
    end

    private

    def validate_persona
      return unprocessable unless current_user.syndicate?

      @syndicate = current_user
    end

    def syndicate_profile_params
      params.require(:syndicate_profile).permit(
        :raised, :raised_amount, :no_times_raised, :industry_market,
        :region, :profile_link, :dealflow, :name, :tagline, :logo
      )
    end
  end
end
