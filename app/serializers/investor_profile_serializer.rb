# frozen_string_literal: true

# Fast json serializer
class InvestorProfileSerializer
  include JSONAPI::Serializer

  attributes :legal_name, :residence, :accreditation, :accepted_investment_criteria

  attribute :nationality do |profile|
    profile.country.name
  end

  attribute :location do |profile|
    profile.country.name
  end
end
