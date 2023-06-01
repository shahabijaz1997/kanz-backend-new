# frozen_string_literal: true

# Fast json serializer
class SyndicateProfileSerializer
  include JSONAPI::Serializer

  attributes :have_you_ever_raised, :raised_amount, :no_times_raised, :industry_market,
             :region, :profile_link, :dealflow, :name, :tagline, :logo
end
