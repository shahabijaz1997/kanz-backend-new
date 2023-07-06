class RealtorsController < ApplicationController
  before_action :set_realtor, only: %i[ show update ]

  def index
    load_countries
    @filtered_realtors = Realtor.ransack(params[:search])
    @realtors = policy_scope(@filtered_realtors.result.includes(:profile).order(created_at: :desc))
  end

  def show
  end

  def update
  end

  private

  def set_realtor
    @realtor = policy_scope(Realtor).find(params[:id])
  end

  def load_countries
    @countries = Country.pluck(:name)
  end
end
