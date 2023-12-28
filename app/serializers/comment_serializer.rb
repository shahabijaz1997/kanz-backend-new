# frozen_string_literal: true

# Comment json serializer
class CommentSerializer
  include JSONAPI::Serializer

  attributes :id, :message, :deal_id, :thread_id, :author_id

  attribute :state do |comment|
    comment.humanized_enum(comment.state)
  end

  attribute :author_name do |comment|
    comment.author.name
  end

  attribute :created_at do |comment|
    DateTime.parse(comment.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end
end
