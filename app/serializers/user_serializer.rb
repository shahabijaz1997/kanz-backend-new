# frozen_string_literal: true

# Fast json serializer
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :email, :created_at
end
