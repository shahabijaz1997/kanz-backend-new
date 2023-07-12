# frozen_string_literal: true

# Question's json serializer
class OptionSerializer
  include JSONAPI::Serializer

  attribute :en do |option|
    {
      id: option.id,
      index: option.index,
      statement: option.statement,
      selected: option.try(:selected) | false
    }
  end

  attribute :ar do |option|
    {
      id: option.id,
      index: option.index,
      statement: option.statement_ar,
      selected: option.try(:selected) | false
    }
  end
end
