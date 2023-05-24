# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :role, :meta_info
  has_one :syndicate_profile, serializer: SyndicateProfileSerializer
end
