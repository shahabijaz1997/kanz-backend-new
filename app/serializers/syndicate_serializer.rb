# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :role, :type, :status

  attribute :syndicate_profile do |syndicate|
    SyndicateProfileSerializer.new(
      syndicate.syndicate_profile
    ).serializable_hash[:data]
  end
end
