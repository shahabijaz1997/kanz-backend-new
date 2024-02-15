# frozen_string_literal: true

class InvestorsController < ApplicationController
  before_action :set_investor, only: %i[show update destroy reactivate]
  before_action :authorize_role!

  def index
    load_countries
    @firms_page = params[:type] == 'firms'
    @filtered_investors = Investor.send(params[:type]).ransack(params[:search])
    @pagy, @investors = pagy(policy_scope(@filtered_investors.result.includes(:profile).order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if user_can_approve(@investor) && @investor.update(update_status_params)
        format.html { redirect_to @investor, notice: 'Successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @investor.destroy
    respond_to do |format|
      format.html { redirect_to @investor, notice: 'Investor deactivated.' }
    end
  end

  def reactivate
    @investor.reactivate
    respond_to do |format|
      format.html { 
        redirect_to @investor.individual_investor? ? individual_path(@investor) : firm_path(@investor), notice: 'Investor reactivated.'
      }
    end
  end

  private

  def set_investor
    @investors = params[:type].present? ? Investor.send(params[:type]) : Investor
    @investor = policy_scope(@investors).find(params[:id])
  end

  def load_countries
    @countries = Country.pluck(:name)
  end

  def update_status_params
    params.require(:investor).permit(:audit_comment, :status)
  end
end
