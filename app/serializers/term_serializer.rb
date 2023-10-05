# frozen_string_literal: true

# Terms json serializer
class TermSerializer
  include JSONAPI::Serializer

  attributes :id, :enabled, :custom_input
end
