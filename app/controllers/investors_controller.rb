# frozen_string_literal: true

class InvestorsController < ApplicationController
  before_action :set_investor, only: %i[show update]

  def individuals
    load_countries
    @filtered_investors = Investor.individuals.ransack(params[:search])
    @pagy, @individual_investors = pagy(policy_scope(@filtered_investors.result.includes(:profile).order(created_at: :desc)))
    authorize @individual_investors
  end

  def firms
    load_countries
    @filtered_investors = Investor.firms.ransack(params[:search])
    @pagy, @firm_investors = pagy(policy_scope(@filtered_investors.result.includes(:profile).order(created_at: :desc)))
    authorize @firm_investors
  end

  def show
    authorize @investor
  end

  def update
    authorize @investor
    respond_to do |format|
      if @investor.update(update_status_params)
        format.html { redirect_to @investor, notice: 'Investor was successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_investor
    @investor = policy_scope(Investor).find(params[:id])
  end

  def load_countries
    @countries = Country.pluck(:name)
  end

  def update_status_params
    params.require(:investor).permit(:audit_comment, :status)
  end
end
