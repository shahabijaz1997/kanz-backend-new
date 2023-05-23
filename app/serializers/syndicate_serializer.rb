# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer
  has_one :syndicate_profile

  attributes :name, :email, :role, :meta_info
end
