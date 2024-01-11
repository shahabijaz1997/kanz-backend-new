# frozen_string_literal: true

# Fast json serializer
class SyndicateDetailSerializer < SyndicateSerializer
  attributes :id

  attribute :logo do |syndicate|
    syndicate.profile.attachment&.url
  end

  attribute :syndicate_name do |syndicate|
    syndicate.profile.name
  end

  attribute :created_at do |syndicate|
    DateTime.parse(syndicate.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :raising_fund do |syndicate|
    !syndicate.no_active_deals.zero?
  end

  attribute :tagline do |syndicate|
    syndicate.profile.tagline
  end

  attribute :industries do |syndicate|
    profile = syndicate.profile
    I18n.locale == :en ? profile.industries&.pluck(:name) : profile.industries&.pluck(:name_ar)
  end

  attribute :regions do |syndicate|
    profile = syndicate.profile
    I18n.locale == :en ? profile.regions&.pluck(:name) : profile.regions&.pluck(:name_ar)
  end

  attribute :about do |syndicate|
    syndicate.profile.about
  end

  attribute :lead do |syndicate|
    {
      name: syndicate.name,
      profile_pic: nil
    }
  end

  attribute :portfolio_stats do |syndicate|
    results = monthly_closed_deals(syndicate)
    {
      labels: results.keys,
      values: results.values,
      total_deals_closed_in_12_months: results.values.reduce(0, :+),
      active_deals_count: syndicate.no_active_deals,
      total_raised: syndicate.invested_amount
    }
  end

  attribute :total_deals do |syndicate|
    syndicate.total_deals
  end

  attribute :no_times_raised do |syndicate|
    syndicate.no_investments
  end

  attribute :profile do |syndicate|
    profile = syndicate.profile

    {
      have_you_ever_raised_before: profile.have_you_ever_raised,
      raised_amount_before_joining_kanz: profile.raised_amount,
      no_times_raised_before_joining_kanz: profile.no_times_raised,
      profile_link: profile.profile_link,
      dealflow: profile.dealflow,
    }
  end

  attributes :investments do |syndicate|
    fundraiser_ids = Deal.live_or_closed.joins(investments: :user).where(investments: { user_id: syndicate.id }).or(Deal.live_or_closed.where(syndicate_id: syndicate.id)).pluck(:user_id)
    companies = FundRaiser.where(id: fundraiser_ids.uniq)

    companies.map do |company|
      {
        name: company.name,
        profile_pic: company.profile.attachment&.url
      }
    end
  end

  attribute :general_partners do |syndicate|
    syndicate.syndicate_members.gp.map do |member|
      {
        name: member.member.name,
        profile_pic: nil # member.profile_pic
      }
    end
  end

  attribute :limited_partners do |syndicate|
    syndicate.syndicate_members.lp.map do |member|
      {
        name: member.member.name,
        profile_pic: nil # member.profile_pic
      }
    end
  end

  private

  class << self
    def monthly_closed_deals(syndicate)
      starting_date = DateTime.current.beginning_of_month - 11.months
      deals = syndicate.deals.where("deals.end_at < ? AND deals.end_at > ?", DateTime.now, starting_date)
      monthly_closed_deals = deals.group_by {|t| t.end_at.strftime('%b')}

      months_hash = last_tweleve_months(starting_date)
      monthly_closed_deals.each do |key, value|
        months_hash[key] = value.size
      end

      months_hash
    end

    def last_tweleve_months(starting_date)
      months_list = (starting_date.month..12).map { |mn| mn } + (1..(starting_date.month - 1)).map {|mn| mn}
      month_names = months_list.map {|month| Date::ABBR_MONTHNAMES[month]}
      month_names.map {|month| [month, 0]}.to_h
    end
  end
end
