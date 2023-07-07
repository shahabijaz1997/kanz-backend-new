class InvestorsController < ApplicationController
  before_action :set_investor, only: %i[ show update ]

  def index
    load_countries
    @filtered_investors = Investor.ransack(params[:search])
    @investors = policy_scope(@filtered_investors.result.includes(:profile).order(created_at: :desc))
    @individual_investors = @investors.individual
    @firm_investors = @investors.firms
  end

  def show
  end

  def update
  end

  private

  def set_investor
    @investor = policy_scope(Investor).find(params[:id])
  end

  def load_countries
    @countries = Country.pluck(:name)
  end
end
