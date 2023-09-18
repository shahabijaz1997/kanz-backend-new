# frozen_string_literal: true

# Feature Features json serializer
class FeatureSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :en do |feature|
    { 
      title: feature.title
      description: feature.description
    }
  end

  attribute :ar do |feature|
    { 
      title: feature.title_ar
      description: feature.description_ar
    }
  end
end