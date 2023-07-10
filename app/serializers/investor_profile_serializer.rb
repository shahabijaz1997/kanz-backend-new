# frozen_string_literal: true

# Fast json serializer
class InvestorProfileSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :en do |profile|
    {
      legal_name: profile.legal_name,
      nationality: profile.country.name,
      location: profile.country.name,
      residence: profile.residence.name,
      accreditation: profile.accreditation_option.statement,
      accepted_investment_criteria: profile.accepted_investment_criteria
    }.except(*keys_to_remove(profile.investor))
  end

  attribute :ar do |profile|
    {
      legal_name: profile.legal_name,
      nationality: profile.country.name_ar,
      location: profile.country.name_ar,
      residence: profile.residence.name_ar,
      accreditation: profile.accreditation_option.statement_ar,
      accepted_investment_criteria: profile.accepted_investment_criteria
    }.except(*keys_to_remove(profile.investor))
  end

  private

  def self.keys_to_remove(investor)
    investor.individual_investor? ? [:legal_name, :location] : [:nationality, :residence]
  end

end
