# frozen_string_literal: true

# Fast json serializer
class InvestorSerializer
  include JSONAPI::Serializer
  has_many :attachments

  attributes :name, :email, :role, :meta_info, :status
end
