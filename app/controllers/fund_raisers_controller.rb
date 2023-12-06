# frozen_string_literal: true

class FundRaisersController < ApplicationController
  before_action :set_fund_raiser, only: %i[show update]
  before_action :authorize_role!

  def index
    load_industry_markets
    @filtered_fund_raisers = FundRaiser.ransack(params[:search])
    @pagy, @fund_raisers = pagy(policy_scope(@filtered_fund_raisers.result.includes(:profile).order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if user_can_approve(@fund_raiser) && @fund_raiser.update(update_status_params)
        format.html { redirect_to @fund_raiser, notice: 'Successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_fund_raiser
    @fund_raiser = policy_scope(FundRaiser).find(params[:id])
  end

  def load_industry_markets
    @industries = Industry.pluck(:name, :id)
  end

  def update_status_params
    params.require(:fund_raiser).permit(:audit_comment, :status)
  end
end
