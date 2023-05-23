# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApplicationController
    before_action :validate_persona

    def show
      user_attributes = SyndicateSerializer.new(
        current_user, include: ['syndicate_profile']
      ).serializable_hash[:data]

      success('', user_attributes)
    end

    def create
      syndicate_profile = current_user.syndicate_profile || current_user.syndicate_profile.new

      if syndicate_profile.update(syndicate_profile_params)
        success('Successfuly updated asyndicate profile.')
      else
        failure(syndicate_profile.errors.full_messages.to_sentence)
      end
    end

    private

    def validate_persona
      unprocessable unless current_user.syndicate?
    end

    def syndicate_profile_params
      params.require(:syndicate_profile).permit(
        :raised, :raised_amount, :no_times_raised, :industry_market,
        :region, :profile_link, :dealflow, :name, :tagline, :logo
      )
    end
  end
end

# Have you raised before? Yes, No
# How much you have raised?
# How many times do you have raised?
# Industry market?
# Region?
# Profile Link
# Expected Dealflow

# Syndicate name
# Add Tagline
# Logo
