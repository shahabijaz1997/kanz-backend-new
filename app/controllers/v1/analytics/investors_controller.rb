# [DONE] Total Investments, Net Value, Multiple [month wise as well]
# [DONE] PerMonth Investment and Per Month Net Value [split by property/startup] 
# [DONE] Investments by rounds
# [DONE] Investments in property by rented/not_rented
# [DONE] Recent Activities 5
# [DONE] Investments paginated/latest first, search, filters

# [PENDING] Create Activities on each action taken by User.
# [DONE] Activities [Search] Filters: [Investor_update, Investment, Deal_creator], paginated

# Insights
  # [DONE] Top syndicates
  # [DONE] 12 Months Comparison to other investors [joined syndicates] [Deal Invites] [Participation Rate by Deal Invites Accepted]
  # [DONE] Top Markets by investment 3 months
  # [DONE] Top Markets by Investment Return

 # [DONE] Deal Basic Information variable for 3 types of deal [Startup with equity, startup with safe, property]
 # [DONE] Deals performance month by month [Invested amount, Net Value, X]
 # [DONE] investment History

# frozen_string_literal: true
module V1
  module Analytics
    class InvestorsController < ApiController
      before_action :set_deal_type_filter, :search_params, only: %i[investments]

      # /1.0/analytics/investors/investments_chart
      def investments_chart
        investment_stats = DashboardAnalytics::MonthlyInvestment.call(current_user)
        success(
          'success',
          {
            records: investment_stats,
            stats: investments_by_deal_type
          }
        )
      end

      # /1.0/investors/analytics/investments
      def investments
        @investments = current_user.investments.ransack(params[:search]).result
        filtered_investments = @investments.filter_by_deal_type(params[:deal_type])
        pagy, filtered_investments = pagy filtered_investments

        success(
          'success',
          {
            records: InvestorInvestmentSerializer.new(filtered_investments).serializable_hash[:data].map {|d| d[:attributes] },
            stats: no_deals_by_type,
            pagy: pagy
          }
        )
      end

      # /1.0/investors/analytics/funding_round_investments
      def funding_round_investments
        equity_deals = Deal.live_or_closed.startup.equity.includes(investments: :user).where(user: {id: current_user.id})
        rounds = FieldAttribute.investment_round.options.map(&:localized_statement)
        round_wise_investments = Hash[rounds.product([0])]

        equity_deals.each do |deal|
          round_wise_investments[deal.investment_round] += deal.investments.sum(:amount).to_f
        end
        success('success', round_wise_investments)
      end

      # /1.0/investors/analytics/property_investments
      def property_investments
        rental_investments = Deal.live_or_closed.property.rental.includes(investments: :user).where(user: {id: current_user.id}).sum("investments.amount")
        non_rental_investments = Deal.live_or_closed.property.non_rental.includes(investments: :user).where(user: {id: current_user.id}).sum("investments.amount")

        success(
          'success',
          { 
            rental_property: rental_investments.to_f,
            non_rental_property: non_rental_investments.to_f
          }
        )
      end


      def activities
        # recent 5
      end

      def all_activites
        # all as paginated and searchable and filterable
      end

      def top_syndicates
        # With Respect to Return
      end

      def comparison
        # 12 Months Comparison to other investors [joined syndicates] [Deal Invites] [Participation Rate by Deal Invites Accepted]
      end

      def s
        # Top Markets by investment 3 months
      end
      
      def saf
        # Top Markets by Investment Return
      end

      def saf
        # investment History [TBD]
      end

      private

      def investments_by_deal_type
        investments = current_user.investments
        {
          all: investment_count_and_amount(investments),
          startup: investment_count_and_amount(investments.by_startup),
          property: investment_count_and_amount(investments.by_property)
        }
      end

      def no_deals_by_type
        {
          all: @investments.count,
          startup: @investments.by_startup.count,
          property: @investments.by_property.count
        }
      end

      def set_deal_type_filter
        params[:deal_type] ||= Deal.deal_types.keys
      end

      def investment_count_and_amount(investments)
        {
          no_investments: investments.count,
          invested_amount: investments.sum(:amount).to_f
        }
      end
    end
  end
end
