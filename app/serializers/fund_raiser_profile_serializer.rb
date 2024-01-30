# frozen_string_literal: true

# Fast json serializer
class FundRaiserProfileSerializer
  include JSONAPI::Serializer

  attributes :company_name, :legal_name, :website, :address,
             :description, :ceo_name, :ceo_email, :total_capital_raised,
             :current_round_capital_target, :currency, :no_of_properties

  attribute :logo do |profile|
    profile.attachment&.url
  end

  attribute :industry_ids do |profile|
    profile.industries&.pluck(:id)
  end

  attribute :industries do |profile|
    I18n.locale == :en ? profile.industries&.pluck(:name) : profile.industries&.pluck(:name_ar)
  end

  attribute :en do |profile|
    {
      residence: profile.residence&.name,
      nationality: profile.nationality&.name,
    }
  end

  attribute :ar do |profile|
    {
      residence: profile.residence&.name_ar,
      nationality: profile.nationality&.name_ar
    }
  end
end
