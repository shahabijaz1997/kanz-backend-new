# frozen_string_literal: true

# Fast json serializer
class FundRaiserSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :type, :status, :language, :profile_states

  attribute :profile_picture_url do |fundraiser|
    fundraiser.profile_picture_url
  end

  attribute :profile do |fund_raiser|
    FundRaiserProfileSerializer.new(
      fund_raiser.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role do |user|
    user.role_title
  end
end
