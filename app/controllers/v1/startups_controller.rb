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
      meta_info = @startup.meta_info
      meta_info = meta_info.merge(startup_params[:meta_info])

      if @startup.update(meta_info:)
        success(I18n.t('startup.update.success.comapny_info'))
      else
        failure(@startup.errors.full_messages.to_sentence)
      end
    end

    private

    def startup_params
      params.require(:startup).permit(meta_info: %i[
                                        company_name legal_name country industry_market website
                                        address logo description ceo_name ceo_email
                                      ])
    end

    def validate_startup
      return unprocessable unless current_user.startup?

      @startup = current_user
    end
  end
end
