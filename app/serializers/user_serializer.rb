# frozen_string_literal: true

# Fast json serializer
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :type, :role, :status
end
