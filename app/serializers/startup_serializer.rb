# frozen_string_literal: true

# Fast json serializer
class StartupSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :type, :status, :language

  attribute :profile do |startup|
    StartupProfileSerializer.new(
      startup.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role do |user|
    user.role_title
  end
end
