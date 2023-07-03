# frozen_string_literal: true

# Country json serializer
class IndustrySerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :en do |industry|
    { name: industry.name }
  end

  attribute :ar do |industry|
    { name: industry.name_ar }
  end
end
