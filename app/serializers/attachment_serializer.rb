# frozen_string_literal: true

# Fast json serializer
class AttachmentSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :attachment_kind

  attribute :url do |attachment|
    attachment.url
  end

  # attribute :uploaded_by do |attachment|
  #   ''
  # end
end
