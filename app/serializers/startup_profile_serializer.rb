# frozen_string_literal: true

# Fast json serializer
class StartupProfileSerializer
  include JSONAPI::Serializer

  attributes :company_name, :legal_name, :website, :address,
             :description, :ceo_name, :ceo_email, :total_capital_raised,
             :current_round_capital_target, :currency

  attribute :logo do |profile|
    profile.attachment&.url
  end

  attribute :industry_ids do |profile|
    profile.industries&.pluck(:id)
  end

  attribute :en do |profile|
    {
      country: profile.country.name
    }
  end

  attribute :ar do |profile|
    {
      country: profile.country.name_ar
    }
  end
end
