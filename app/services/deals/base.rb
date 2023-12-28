module Deals
  class Base < ApplicationService
    attr_reader :deal, :user

    def initialize(deal, user)
      @deal = deal
      @user = user
    end

    def call
      english = I18n.locale == :en

      {
        id: deal.id,
        raised: total_raised,
        committed: total_committed,
        investors: total_investors,
        category: deal.deal_type,
        selling_price: deal.target,
        title: deal.title,
        description: deal.description,
        status: deal.humanized_enum(deal.status),
        start_at: deal.start_at.blank? ? '' : Date.parse(deal.start_at.to_s).strftime('%d/%m/%Y'),
        end_at: deal.end_at.blank? ? '' : Date.parse(deal.end_at.to_s).strftime('%d/%m/%Y'),
        token: deal.token,
        is_invested: user.investments.exists?(deal_id: deal.id),
        my_invested_amount: user.investments.find_by(deal_id: deal.id)&.amount,
        current_deal_syndicate: deal.syndicate_id == user.id && deal.syndicate?,
        syndicate_id: deal.syndicate_id,
        model: deal.humanized_enum(deal.model)
      }.merge(association_attributes)
    end

    private

    def association_attributes
      deal.startup? ? startup_attributes : property_attributes
    end

    def startup_attributes
      Deals::Startup.call(deal)
    end

    def property_attributes
      Deals::Property.call(deal)
    end

    def total_raised
      deal.raised
    end

    def total_committed
      deal.raised
    end

    def total_investors
      deal.investors_count
    end
  end
end
