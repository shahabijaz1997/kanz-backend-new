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
        @deals = Deal.closed.joins(:investments).where(investments: { id: current_user.investments.pluck(:id) }).ransack(params[:search]).result
        filtered_deals = @deals.by_type(params[:deal_type])
        pagy, investments = pagy current_user.investments.includes(:deal).where(deal: { id: filtered_deals.pluck(:id) }).order(created_at: :desc)

        success(
          'success',
          {
            records: InvestorInvestmentSerializer.new(investments).serializable_hash[:data].map {|d| d[:attributes] },
            stats: no_deals_by_type,
            pagy: pagy
          }
        )
      end

      # /1.0/investors/analytics/funding_round_investments
      def funding_round_investments
        equity_deals = Deal.closed.startup.equity
        rounds = FieldAttribute.investment_round.options.map(&:localized_statement)
        round_wise_investments = Hash[rounds.product([0])]

        equity_deals.each do |deal|
          round_wise_investments[deal.investment_round] += Investment.where(deal_id: deal.id).joins(:user).where(user: {id: current_user.id}).distinct.sum(:amount).to_f
        end

        success('success', round_wise_investments)
      end

      # /1.0/investors/analytics/property_investments
      def property_investments
        rental_investments = Deal.closed.property.rental.includes(investments: :user).where(user: {id: current_user.id}).sum("investments.amount")
        non_rental_investments = Deal.closed.property.non_rental.includes(investments: :user).where(user: {id: current_user.id}).sum("investments.amount")

        success(
          'success',
          { 
            rental_property: rental_investments.to_f,
            non_rental_property: non_rental_investments.to_f
          }
        )
      end

      def recent_activities
        notifications = current_user.notifications.pending_read.first(RECENT_ACTIVITY_COUNT)
        success(
          'sucess',
          NotificationSerializer.new(notifications).serializable_hash[:data].map{|d| d[:attributes]}
        )
      end

      private

      def investments_by_deal_type
        investments = current_user.investments.joins(:deal).where(deal: {status: :closed})
        {
          all: investment_count_and_amount(investments),
          startup: investment_count_and_amount(investments.by_startup),
          property: investment_count_and_amount(investments.by_property)
        }
      end

      def no_deals_by_type
        {
          all: @deals.count,
          startup: @deals.startup.count,
          property: @deals.property.count
        }
      end

      def set_deal_type_filter
        params[:deal_type] ||= Deal.deal_types.keys
      end

      def investment_count_and_amount(investments)
        investment_value = investment_current_value(investments)
        invested_amount = investments.sum(:amount).to_f
        multiple = invested_amount > 0 ? (investment_value / invested_amount).round(2) : 1.0
        {
          no_investments: investments.count,
          invested_amount: invested_amount,
          invested_value: investment_value,
          multiple: multiple,
          irr: ((multiple - 1) * 100)
        }
      end

      def investment_current_value(investments)
        investments.map{ |investment| investment.amount.to_f * investment.deal.valuation_multiple }.reduce(&:+).to_f
      end
    end
  end
end
