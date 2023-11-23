# frozen_string_literal: true

# Fast json serializer
class PropertyOwnerProfileSerializer
  include JSONAPI::Serializer

  attributes :no_of_properties

  attribute :en do |profile|
    {
      nationality: profile.nationality.name,
      residence: profile.residence.name
    }
  end

  attribute :ar do |profile|
    {
      nationality: profile.nationality.name_ar,
      residence: profile.residence.name_ar
    }
  end
end
