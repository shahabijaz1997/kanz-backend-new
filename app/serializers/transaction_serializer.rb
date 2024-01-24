# frozen_string_literal: true

# Fast json serializer
class TransactionSerializer
  include JSONAPI::Serializer
  attributes :id, :amount, :transaction_type, :status, :method, :description, :timestamp

end
