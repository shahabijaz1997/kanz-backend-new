# frozen_string_literal: true

# Fast json serializer
class SyndicateProfileSerializer
  include JSONAPI::Serializer

  attributes :have_you_ever_raised, :raised_amount, :no_times_raised,
             :profile_link, :dealflow, :name, :tagline

  attribute :logo do |profile|
    profile.attachment&.url
  end

  attribute :region_ids do |profile|
    profile.regions&.pluck(:id)
  end

  attribute :industry_ids do |profile|
    profile.industries&.pluck(:id)
  end

  attribute :regions do |profile|
    profile.regions&.pluck(:name)
  end

  attribute :industries do |profile|
    profile.industries&.pluck(:name)
  end
end
