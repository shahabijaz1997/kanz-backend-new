# frozen_string_literal: true

# Fast json serializer
class StartupSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :role, :meta_info, :status
end
