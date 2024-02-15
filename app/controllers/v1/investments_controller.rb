# frozen_string_literal: true

module V1
  class InvestmentsController < ApiController
    include WalletHelper

    before_action :find_deal, only: %i[create index revert]
    before_action :find_investment, only: %i[show]
    before_action :balance_check, only: %i[create]

    def index
      pagy, investments = pagy @deal.investments
      success(
        'success',
        {
          records: InvestmentSerializer.new(investments).serializable_hash[:data].map{ |d| d[:attributes] },
          pagy: pagy,
          stats: {}
        }
      )
    end

    def create
      investment = current_user.investments.new(investment_params.merge(deal_id: @deal.id))
      if investment.save
        success('success', InvestmentSerializer.new(investment).serializable_hash[:data][:attributes])
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

    def revert
      @investment = @deal.investments.find_by(user: current_user)
      return failure(I18n.t('investment.not_found'), 404) if @investment.blank?
      return failure(I18n.t('wallet.irrevertable'),404) unless @investment.refundable?

      @investment.refund
    end

    private

    def investment_params
      params.require(:investment).permit(:amount)
    end

    def find_deal
      @deal = Deal.find_by(id: params[:deal_id])

      failure(I18n.t('deal.not_found'), 401) if @deal.blank?
    end

    def find_investment
      @investment = current_user.investments.find_by(id: params[:id])
      failure(I18n.t('investment.not_found'), 401) if @investment.blank?
    end

    def balance_check
      unprocessable(I18n.t('wallet.low_balance')) unless balance_available?(investment_params[:amount], converted: @deal.startup?)
    end
  end
end
