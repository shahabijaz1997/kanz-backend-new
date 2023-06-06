# frozen_string_literal: true

# Fast json serializer
class RoleViseAttachmentSerializer
  include JSONAPI::Serializer
  attributes :name, :label, :index, :required, :allowed_file_types
end
