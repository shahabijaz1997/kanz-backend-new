# frozen_string_literal: true

module V1
  module Analytics
    class InsightsController < ApiController
      before_action :find_deal

      def top_syndicates
        success(
          'success',
          DealDetailSerializer.new(@deal).serializable_hash[:data][:attributes]
        )
      end

      # average of syndicate
      # monthly_deal_invites
      # participation_rate
      def compare_to_other_investor
        success(
          'success',
          { 
            stats: investment_stats,
            charts: DashboardAnalytics::MonthlyDealReturns.call(current_user, @deal)
          }
        )
      end

      # Your top markets by multiple
      def top_markets_by_multiple
      end

      # Your top markets on kanz by investment in last 3 months
      def top_markets_on_kanz

      end

      private
      
      def top_syndicates
        user.investments
        deals.where.valuation_updates
        deal.valuation_multiple # default set to zero
      end

      def top_markets
        deal.industries # set industries of fundraiser to deal
      end
    end
  end
end
