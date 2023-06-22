# frozen_string_literal: true

# Fast json serializer
class InvestorSerializer
  include JSONAPI::Serializer
  has_many :attachments

  attributes :name, :email, :type, :status, :language

  attribute :profile do |investor|
    keys = investor.individual_investor? ? [:legal_name,:location] : [:nationality, :residence]
    InvestorProfileSerializer.new(
      investor.profile
    ).serializable_hash[:data]&.fetch(:attributes)&.except(*keys)
  end

  attribute :role do |user|
    user.role_title
  end

  attribute :role do |user|
    user.role_title_ar
  end
end
