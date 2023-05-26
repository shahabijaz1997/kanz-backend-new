# frozen_string_literal: true

# Startups apis
module V1
  class RealtorsController < ApplicationController
    before_action :validate_realtor

    def show
      realtor_attributes = PropertySerializer.new(@realtor).serializable_hash[:data][:attributes]
      success(I18n.t('property.get.success.show'), realtor_attributes)
    end

    def create
      meta_info = @realtor.meta_info
      meta_info = meta_info.merge(realtor_params[:meta_info])

      if @realtor.update(meta_info:)
        success(I18n.t('property.update.success.owner'))
      else
        failure(@realtor.errors.full_messages.to_sentence)
      end
    end

    private

    def realtor_params
      params.require(:realtor).permit(meta_info: %i[nationality residence no_of_properties])
    end

    def validate_realtor
      return unprocessable unless current_user.realtor?

      @realtor = current_user
    end
  end
end
