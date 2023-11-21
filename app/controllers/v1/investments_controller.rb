# frozen_string_literal: true

module V1
  class InvestmentsController < ApiController
    before_action :find_deal, :set_investments, only: %i[index]
    before_action :find_deal, only: %i[create]
    before_action :find_investment, only: %i[show]

    def index
      success(
        'success',
        InvestmentSerializer.new(@investments).serializable_hash[:data].map{|d| d[:attributes] }
      )
    end

    def create
      investment = current_user.investments.create(investment_params.merge(deal_id: @deal.id))
      if investment.valid?
        success('success', 200)
      else
        failure(investment.errors.full_messages.to_sentence, 401)
      end
    end

    def show
      success(
        'success',
        InvestmentSerializer.new(@investment).serializable_hash[:data][:attributes]
      )
    end

    def revert; end

    private

    def investment_params
      params.require(:investment).permit(:amount)
    end

    def find_deal
      @deal = Deal.find_by(id: params[:deal_id])

      failure('Deal not found', 401) if @deal.blank?
    end

    def set_investments
      @investments = @deal.present? ? @deal.investments : current_user.investments
    end

    def find_investment
      @investment = current_user.investments.find_by(id: params[:id])
      failure('Investment not found', 401) if @investment.blank?
    end
  end
end
