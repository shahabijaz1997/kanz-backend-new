# frozen_string_literal: true

# Fast json serializer
class SyndicateDetailSerializer < SyndicateSerializer
  attributes :id, :name

  attribute :logo do |syndicate|
    syndicate.profile&.attachment&.url
  end

  attribute :created_at do |syndicate|
    DateTime.parse(syndicate.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :total_deals do |syndicate|
    syndicate.total_deals
  end

  attribute :active_deals do |syndicate|
    syndicate.no_active_deals
  end

  attribute :raising_fund do |syndicate|
    !syndicate.no_active_deals.zero?
  end

  attribute :no_times_raised do |syndicate|
    syndicate.no_investments
  end

  attribute :raised_amount do |syndicate|
    syndicate.invested_amount
  end

  attribute :profile do |syndicate|
    profile = syndicate.profile

    {
      syndicate_name: profile.name,
      tagline: profile.tagline,
      about: profile.about,
      have_you_ever_raised_before: profile.have_you_ever_raised,
      raised_amount_before_joining_kanz: profile.raised_amount,
      no_times_raised_before_joining_kanz: profile.no_times_raised,
      profile_link: profile.profile_link,
      dealflow: profile.dealflow,
      industries: I18n.locale == :en ? profile.industries&.pluck(:name) : profile.industries&.pluck(:name_ar),
      regions: I18n.locale == :en ? profile.regions&.pluck(:name) : profile.regions&.pluck(:name_ar)
    }
  end
end
