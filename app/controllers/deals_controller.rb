# frozen_string_literal: true

class DealsController < ApplicationController
  before_action :set_deal, only: %i[show update]
  before_action :authorize_role!

  def index
    @filtered_deals = Deal.send(params[:type].split('_').join('')).ransack(params[:search])
    @pagy, @deals = pagy(policy_scope(@filtered_deals.result.order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if @deal.update(update_status_params)
        format.html { redirect_to @deal, notice: 'Successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_deal
    @deal = policy_scope(Deal).find(params[:id])
  end

  def update_status_params
    params.require(:deal).permit(:audit_comment, :model, :status)
  end
end
