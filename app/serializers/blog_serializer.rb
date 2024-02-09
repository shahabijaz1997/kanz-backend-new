# frozen_string_literal: true

# Fast json serializer
class BlogSerializer
  include JSONAPI::Serializer
  attributes :title, :slug, :introduction

  attribute :updated_at do |object|
    object.updated_at.strftime('%d/%m/%Y %I:%M:%S %p')
  end

  attribute :author do |object|
    {
      name: object.author.fullname
    }
  end

  attribute :content, if: Proc.new { |record, params| params && params[:detailed] != false }
end
