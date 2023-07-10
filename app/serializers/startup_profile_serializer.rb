# frozen_string_literal: true

# Fast json serializer
class StartupProfileSerializer
  include JSONAPI::Serializer

  attributes :company_name, :legal_name, :website, :address,
             :description, :ceo_name, :ceo_email, :total_capital_raised,
             :current_round_capital_target

  attribute :logo do |profile|
    profile.attachment&.url
  end

  attribute :en do |profile|
    {
      country: profile.country.name,
      industry_market: profile.industries&.pluck(:name)
    }
  end

  attribute :ar do |profile|
    {
      country: profile.country.name_ar,
      industry_market: profile.industries&.pluck(:name_ar)
    }
  end
end
