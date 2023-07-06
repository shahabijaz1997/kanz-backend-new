class StartupsController < ApplicationController
  before_action :set_startup, only: %i[ show update ]

  def index
    load_industry_markets
    @filtered_startups = Startup.ransack(params[:search])
    @startups = policy_scope(@filtered_startups.result.includes(:profile).order(created_at: :desc))
  end

  def show
  end

  def update
  end

  private

  def set_startup
    @startup = policy_scope(Startup).find(params[:id])
  end

  def load_industry_markets
    @industry_markets = StartupProfile.pluck(:industry_market).flatten.reject(&:nil?).uniq
  end
end
