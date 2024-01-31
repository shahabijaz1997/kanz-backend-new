# frozen_string_literal: true

# Fast json serializer
class WalletSerializer
  include JSONAPI::Serializer
  attributes :balance
end
