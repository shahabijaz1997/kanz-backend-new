# frozen_string_literal: true

# Fast json serializer
class InvestorSerializer
  include JSONAPI::Serializer
  has_many :attachments

  attributes :name, :email, :role, :type, :status

  attribute :profile do |investor|
    keys = investor.individual_investor? ? [:legal_name,:location] : [:nationality, :residence]
    InvestorProfileSerializer.new(
      investor.profile
    ).serializable_hash[:data][:attributes].except(*keys)
  end
end
