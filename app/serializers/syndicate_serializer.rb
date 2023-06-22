# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :type, :status, :language

  attribute :profile do |syndicate|
    SyndicateProfileSerializer.new(
      syndicate.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role do |user|
    user.role_title
  end
end
