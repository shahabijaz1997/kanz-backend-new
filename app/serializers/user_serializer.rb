# frozen_string_literal: true

# Fast json serializer
class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :role, :meta_info
end
