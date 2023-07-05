# frozen_string_literal: true

# Startups apis
module V1
  class RealtorsController < ApiController
    before_action :validate_realtor

    def show
      realtor_attributes = RealtorSerializer.new(@realtor).serializable_hash[:data][:attributes]
      success(I18n.t('realtor.get.success.show'), realtor_attributes)
    end

    def create
      profile = @realtor.profile || RealtorProfile.new(realtor_id: @realtor.id)

      if profile.update(profile_params)
        success(I18n.t('realtor.update.success.owner'))
      else
        failure(profile.errors.full_messages.to_sentence)
      end
    end

    private

    def profile_params
      params.require(:realtor_profile).permit(:nationality_id, :residence_id, :no_of_properties)
    end

    def validate_realtor
      return unprocessable unless current_user.realtor?

      @realtor = current_user
    end
  end
end
