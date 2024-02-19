# frozen_string_literal: true
module V1
  module Analytics
    class DealsController < ApiController
      before_action :find_deal

      def show
        success(
          'success',
          DealDetailSerializer.new(@deal).serializable_hash[:data][:attributes]
        )
      end

      def stats
        success(
          'success',
          { 
            stats: investment_stats,
            charts: DashboardAnalytics::MonthlyDealReturns.call(current_user, @deal)
          }
        )
      end


      private
      
      def investment_stats
        invested_amount = current_user.investments.find_by(deal_id: @deal.id).amount.to_f
        {
          invested_amount: invested_amount,
          net_value: (@deal.valuation_multiple * invested_amount),
          multiple: @deal.valuation_multiple
        }
      end

      def find_deal
        @deal = Deal.closed.find_by(token: params[:token])
        failure(I18n.t('deal.not_found')) if @deal.blank?
      end
    end
  end
end
