# frozen_string_literal: true

class RealtorsController < ApplicationController
  before_action :set_realtor, only: %i[show update]
  before_action :authorize_role!

  def index
    load_countries
    @filtered_realtors = Realtor.ransack(params[:search])
    @pagy, @realtors = pagy(policy_scope(@filtered_realtors.result.includes(:profile).order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if @realtor.update(update_status_params)
        format.html { redirect_to @realtor, notice: 'Successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_realtor
    @realtor = policy_scope(Realtor).find(params[:id])
  end

  def load_countries
    @countries = Country.pluck(:name)
  end

  def update_status_params
    params.require(:realtor).permit(:audit_comment, :status)
  end
end
