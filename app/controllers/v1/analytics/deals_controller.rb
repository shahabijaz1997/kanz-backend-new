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
            charts: chart_data
          }
        )
      end


      private
      
      def investment_stats
        invested_amount = current_user.investments.where(deal_id: @deal.id).sum(:amount).to_f
        {
          invested_amount: invested_amount,
          net_value: (@deal.investment_multiple * invested_amount),
          multiple: @deal.investment_multiple
        }
      end

      def find_deal
        @deal = Deal.live_or_closed.find_by(token: params[:token])
        failure(I18n.t('deal.not_found')) if @deal.blank?
      end

      def chart_data
        {
          months: ,
          investments: [],
          net_values: []
        }
      end
    end
  end
end
