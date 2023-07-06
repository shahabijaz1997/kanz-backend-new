class SyndicatesController < ApplicationController
  before_action :set_syndicate, only: %i[ show update ]

  def index
    load_regions
    load_industry_markets
    @filtered_syndicates = Syndicate.ransack(params[:search])
    @syndicates = policy_scope(@filtered_syndicates.result.includes(:profile).order(created_at: :desc))
  end

  def show
  end

  def update
  end

  private

  def set_syndicate
    @syndicate = policy_scope(Syndicate).find(params[:id])
  end

  def load_regions
    @regions = SyndicateProfile.pluck(:region).flatten.reject(&:nil?).uniq
  end

  def load_industry_markets
    @industry_markets = SyndicateProfile.pluck(:industry_market).flatten.reject(&:nil?).uniq
  end
end
