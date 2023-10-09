# frozen_string_literal: true

# Question's json serializer
class ExternalLinkSerializer
  include JSONAPI::Serializer

  attributes :id, :url, :index
end
