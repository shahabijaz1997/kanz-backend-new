# frozen_string_literal: true

# Terms json serializer
class TermSerializer
  include JSONAPI::Serializer

  attributes :id, :enabled, :value

  attribute :en do |term|
    { title: term.statement }
  end

  attribute :ar do |term|
    { title: term.statement_ar }
  end
end
