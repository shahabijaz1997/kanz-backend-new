# frozen_string_literal: true

# Fast json serializer
class PropertySerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :role, :type, :meta_info, :status
end
