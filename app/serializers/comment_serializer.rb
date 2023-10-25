# frozen_string_literal: true

# Comment json serializer
class CommentSerializer
  include JSONAPI::Serializer

  attributes :id, :message, :author_id, :deal_id, :thread_id, :state
end
