# frozen_string_literal: true

# Fast json serializer
class TransactionSerializer
  include JSONAPI::Serializer
  attributes :id, :amount, :transaction_type, :status, :method, :description

  attribute :timestamp do |object|
    object.timestamp.strftime('%d/%m/%Y %I:%M:%S %p')
  end
end
