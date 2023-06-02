# frozen_string_literal: true

# Fast json serializer
class RealtorProfileSerializer
  include JSONAPI::Serializer

  attributes :no_of_properties

  attribute :nationality do |profile|
    profile.nationality.name
  end

  attribute :residence do |profile|
    profile.residence.name
  end
end
