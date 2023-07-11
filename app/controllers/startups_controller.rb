class StartupsController < ApplicationController
  before_action :set_startup, only: %i[ show update ]

  def index
    load_industry_markets
    @filtered_startups = Startup.ransack(params[:search])
    @pagy, @startups = pagy(policy_scope(@filtered_startups.result.includes(:profile).order(created_at: :desc)))
    authorize @startups
  end

  def show
    authorize @startup
  end

  def update
    authorize @startup
    respond_to do |format|
      if @startup.update(update_status_params)
        format.html { redirect_to @startup, notice: "Startup was successfully updated." }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_startup
    @startup = policy_scope(Startup).find(params[:id])
  end

  def load_industry_markets
    @industry_markets = StartupProfile.pluck(:industry_market).flatten.reject(&:nil?).uniq
  end

  def update_status_params
    params.require(:startup).permit(:audit_comment, :status)
  end
end
