# frozen_string_literal: true

# Fast json serializer
class RealtorSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :role, :type, :status

  attribute :profile do |realtor|
    RealtorProfileSerializer.new(
      realtor.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end
end
