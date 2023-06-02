# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :role, :type, :status

  attribute :profile do |syndicate|
    SyndicateProfileSerializer.new(
      syndicate.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end
end
