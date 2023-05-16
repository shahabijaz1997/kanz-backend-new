# frozen_string_literal: true

# Fast json serializer
class AttachmentSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :attachment_kind, :file_urls, :file_thumbnail_urls, :parent_id, :parent_type
end
