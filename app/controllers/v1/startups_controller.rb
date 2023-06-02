# frozen_string_literal: true

# Startups apis
module V1
  class StartupsController < ApplicationController
    before_action :validate_startup

    def show
      startup_attributes = StartupSerializer.new(@startup).serializable_hash[:data][:attributes]
      success(I18n.t('startup.get.success.show'), startup_attributes)
    end

    def create
      profile = @startup.profile || StartupProfile.new(startup_id: @startup.id)

      if profile.update(profile_params)
        success(I18n.t('startup.update.success.comapny_info'))
      else
        failure(profile.errors.full_messages.to_sentence)
      end
    end

    private

    def profile_params
      params.require(:startup).permit(
        :company_name, :legal_name, :website, :address, :logo, :description, :country_id,
        :ceo_name, :ceo_email, :total_capital_raised, :current_round_capital_target,
        industry_market: []
      )
    end

    def validate_startup
      return unprocessable unless current_user.startup?

      @startup = current_user
    end
  end
end
