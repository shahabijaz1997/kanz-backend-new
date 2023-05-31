# frozen_string_literal: true

# Country json serializer
class CountrySerializer
  include JSONAPI::Serializer

  attributes :id, :name, :states
end
