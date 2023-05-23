# frozen_string_literal: true

# Fast json serializer
class SyndicateProfileSerializer
  include JSONAPI::Serializer

  attributes :name, :tagline, :previously_raised, :raised_amount, :no_times_raised,
             :industry_market, :region, :profile_link, :dealflow, :logo
end
