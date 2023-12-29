# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attribute :id do |syndicate|
    syndicate.id
  end

  attribute :name do |syndicate|
    syndicate.name
  end

  attribute :email do |syndicate|
    syndicate.email
  end

  attribute :type do |syndicate|
    syndicate.type
  end

  attribute :status do |syndicate|
    syndicate.status
  end

  attribute :language do |syndicate|
    syndicate.language
  end

  attribute :profile_states do |syndicate|
    syndicate.profile_states
  end

  attribute :profile do |syndicate|
    SyndicateProfileSerializer.new(
      syndicate.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role do |user|
    user.role_title
  end
end
