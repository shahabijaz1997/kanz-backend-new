# frozen_string_literal: true

# Fast json serializer
class RoleViseAttachmentSerializer
  include JSONAPI::Serializer
  attributes :label, :index, :required, :allowed_file_types

  attribute :en do |attachment|
    {
      name: attachment.name,
      label: attachment.label
    }
  end

  attribute :ar do |attachment|
    {
      name: attachment.name_ar,
      label: attachment.label_ar
    }
  end
end
