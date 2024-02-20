# frozen_string_literal: true

module V1
  module Analytics
    class InsightsController < ApiController
      def top_syndicates
        success('success', extract_top_syndicates)
      end

      # average of syndicate
      # monthly_deal_invites
      # participation_rate
      def compare_to_other_investor
        results = { 
          syndicates_joined: average_syndicates_joined(current_user.id, true), # average_syndicates_joined over last 12 months,
          sj_others: average_syndicates_joined(current_user.id, false),
          monthly_deal_invites: average_monthly_deal_invites(current_user.id, true),
          mdi_others: average_monthly_deal_invites(current_user.id, false),
          participation_rate: 0.4,
          pr_others: 0.3
        }
        success('success',results)
      end

      # Your top markets by multiple
      def markets_by_multiple
        results = [
          { title: 'Tech', multiple: 1.2 },
          { title: 'Chemical', multiple: 0.9 },
          { title: 'Manufactoring', multiple: 1.4 },
          { title: 'Cosmetics', multiple: 0.8 }
        ]

        success('success',results)
      end

      # Your top markets on kanz by investment in last 3 months
      def markets_by_investment_share
        results = [
          {title: 'Health Care', value: 20, unit: '%'},
          {title: 'Software', value: 9, unit: '%'},
          {title: 'Education', value: 15, unit: '%'},
          {title: 'AI / ML', value: 13, unit: '%'}
        ]

        success('success', results)
      end

      private
      
      def extract_top_syndicates
        deal_ids = current_user.investments.pluck(:deal_id)
        deals = Deal.closed.where(id: deal_ids).order(valuation_multiple: :desc).first(5).map do |deal|
          {
            logo: (deal.classic? ? deal.user.profile.logo : deal.syndicate.profile.logo),
            title: (deal.classic? ? deal.user.company_name : deal.syndicate.company_name),
            investment_multiple: deal.valuation_multiple
          }
        end
      end

      def top_markets
        # results = Investment.group(:deal_id).where("created_at > ?", 3.months.ago).sum(:amount)
        # top_investments = results.sort_by { |key, value| value }.last(5).reverse
        # top_investments.each do |deal_id, amount|

        # end
        # set industries of fundraiser to deal
      end

      def average_syndicates_joined(user_id, flag)
        if flag
          SyndicateMember.where('member_id = ? and created_at > ?', user_id, Date.today.prev_month(12)).count / 12
        else
          SyndicateMember.where('member_id != ? and created_at > ?', user_id, Date.today.prev_month(12)).count / 12
        end
      end

      def average_monthly_deal_invites(user_id, flag)
        if flag
          Invite.investment.where('invitee_id = ? and created_at > ?', user_id, Date.today.prev_month(12)).count / 12
        else
          Invite.investment.where('invitee_id != ? and created_at > ?', user_id, Date.today.prev_month(12)).count / 12
        end
      end

      def average_participation(user_id, flag)
        if flag
          Invite.investment.where('invitee_id = ? and created_at > ?', user_id, Date.today.prev_month(12)).count
        else
          Invite.investment.where('invitee_id != ? and created_at > ?', user_id, Date.today.prev_month(12)).count
        end
      end
    end
  end
end
