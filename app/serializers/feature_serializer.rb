# frozen_string_literal: true

# Feature Features json serializer
class FeatureSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :index
end