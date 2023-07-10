# frozen_string_literal: true

# Fast json serializer
class SyndicateProfileSerializer
  include JSONAPI::Serializer

  attributes :have_you_ever_raised, :raised_amount, :no_times_raised,
             :profile_link, :dealflow, :name, :tagline

  attribute :logo do |profile|
    profile.attachment&.url
  end

  attributes :en do |profile|
    {
      industry_market: profile.industries&.pluck(:name),
      region: profile.regions&.pluck(:name)
    }
  end

  attributes :ar do |profile|
    {
      industry_market: profile.industries&.pluck(:name_ar),
      region: profile.regions&.pluck(:name_ar)
    }
  end
end
