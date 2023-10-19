# frozen_string_literal: true

class StartupsController < ApplicationController
  before_action :set_startup, only: %i[show update]
  before_action :authorize_role!

  def index
    load_industry_markets
    @filtered_startups = Startup.ransack(params[:search])
    @pagy, @startups = pagy(policy_scope(@filtered_startups.result.includes(:profile).order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if user_can_approve(@startup) && @startup.update(update_status_params)
        format.html { redirect_to @startup, notice: 'Successfully updated.' }
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
    @industries = Industry.pluck(:name, :id)
  end

  def update_status_params
    params.require(:startup).permit(:audit_comment, :status)
  end
end
