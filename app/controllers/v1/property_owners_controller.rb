# frozen_string_literal: true

# Startups apis
module V1
  class PropertyOwnersController < ApiController
    before_action :validate_property_owner

    def show
      property_owner_attributes = PropertOwnerSerializer.new(@property_owner).serializable_hash[:data][:attributes]
      success(I18n.t('property_owner.get.success.show'), property_owner_attributes)
    end

    def create
      profile = @property_owner.profile || PropertyOwnerProfile.new(property_owner_id: @property_owner.id)

      if profile.update(profile_params)
        success(I18n.t('property_owner.update.success.owner'))
      else
        failure(profile.errors.full_messages.to_sentence)
      end
    end

    private

    def profile_params
      params.require(:property_owner_profile).permit(:nationality_id, :residence_id, :no_of_properties)
    end

    def validate_property_owner
      return unprocessable unless current_user.property_owner?

      @property_owner = current_user
    end
  end
end
