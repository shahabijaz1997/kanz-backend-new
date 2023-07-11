# frozen_string_literal: true

class SyndicatesController < ApplicationController
  before_action :set_syndicate, only: %i[show update]

  def index
    load_regions
    load_industry_markets
    @filtered_syndicates = Syndicate.ransack(params[:search])
    @pagy, @syndicates = pagy(policy_scope(@filtered_syndicates.result.includes(:profile).order(created_at: :desc)))
    authorize @syndicates
  end

  def show
    authorize @syndicate
  end

  def update
    authorize @syndicate
    respond_to do |format|
      if @syndicate.update(update_status_params)
        format.html { redirect_to @syndicate, notice: 'Syndicate was successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_syndicate
    @syndicate = policy_scope(Syndicate).find(params[:id])
  end

  def load_regions
    @regions = SyndicateProfile.pluck(:region).flatten.compact.uniq
  end

  def load_industry_markets
    @industry_markets = SyndicateProfile.pluck(:industry_market).flatten.compact.uniq
  end

  def update_status_params
    params.require(:syndicate).permit(:audit_comment, :status)
  end
end
