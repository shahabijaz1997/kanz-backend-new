# frozen_string_literal: true

# Fast json serializer
class AttachmentSerializer
  include JSONAPI::Serializer
  attributes :id, :attachment_kind

  attribute :name do |attachment|
    attachment.attachment_name
  end

  attribute :url do |attachment|
    attachment.url
  end

  # attribute :uploaded_by do |attachment|
  #   ''
  # end
end
