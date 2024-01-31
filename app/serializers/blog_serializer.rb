# frozen_string_literal: true

# Fast json serializer
class BlogSerializer
  include JSONAPI::Serializer
  attributes :id, :title, :content

  attribute :updated_at do |object|
    object.updated_at.strftime('%d/%m/%Y %I:%M:%S %p')
  end

  attribute :author do |object|
    {
      name: object.author.fullname
    }
  end
end
