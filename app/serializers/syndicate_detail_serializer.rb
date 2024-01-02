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

  attribute :deal_closing_bar_chart_data do |syndicate|
    results = monthly_closed_deals(syndicate)
    {
      labels: results.keys
      values: results.values
    }
  end

  private

  class << self
    def monthly_closed_deals(syndicate)
      starting_date = DateTime.current.beginning_of_month - 11.months
      deals = syndicate.deals.where("deals.end_at < ? AND deals.end_at > ?", DateTime.now, starting_date)
      monthly_closed_deals = deals.group_by {|t| t.end_at.strftime('%B')}

      months_hash = last_tweleve_months(starting_date)
      monthly_closed_deals.each do |key, value|
        months_hash[key] = value.size
      end

      months_hash
    end

    def last_tweleve_months(starting_date)
      months_list = (starting_date.month..12).map { |mn| mn } + (1..(starting_date.month - 1)).map {|mn| mn}
      month_names = months_list.map {|month| Date::MONTHNAMES[month]}
      month_names.map {|month| [month, 0]}.to_h
    end
  end
end
