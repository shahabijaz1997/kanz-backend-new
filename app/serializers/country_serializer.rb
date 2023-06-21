# frozen_string_literal: true

# Country json serializer
class CountrySerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :en do |country|
    { name: country.name }
  end

  attribute :ar do |country|
    { name: country.name_ar }
  end
end
