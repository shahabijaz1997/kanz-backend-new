# frozen_string_literal: true

# Country json serializer
class RegionSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :en do |region|
    { name: region.name }
  end

  attribute :ar do |region|
    { name: region.name_ar }
  end
end
