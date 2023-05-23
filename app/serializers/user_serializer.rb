# frozen_string_literal: true

# Fast json serializer
class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :type, :role, :meta_info, :status
end
