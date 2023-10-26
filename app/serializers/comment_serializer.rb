# frozen_string_literal: true

# Comment json serializer
class CommentSerializer
  include JSONAPI::Serializer

  attributes :id, :message, :deal_id, :thread_id, :state

  attribute :author_name do |comment|
    comment.author.name
  end
end
