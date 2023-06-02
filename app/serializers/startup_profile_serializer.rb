# frozen_string_literal: true

# Fast json serializer
class StartupProfileSerializer
  include JSONAPI::Serializer

  attributes :company_name, :legal_name, :industry_market, :website, :address,
             :logo, :description, :ceo_name, :ceo_email, :total_capital_raised, :current_round_capital_target

  attribute :country do |profile|
    profile.country.name
  end
end
