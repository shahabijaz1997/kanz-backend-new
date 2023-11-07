# frozen_string_literal: true

# Fast json serializer
class PropertOwnerSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :type, :status, :language, :profile_states

  attribute :profile do |property_owner|
    PropertyOwnerProfileSerializer.new(
      property_owner.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role do |user|
    user.role_title
  end
end
