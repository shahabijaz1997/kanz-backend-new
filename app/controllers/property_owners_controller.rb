# frozen_string_literal: true

class PropertyOwnersController < ApplicationController
  before_action :set_property_owner, only: %i[show update]
  before_action :authorize_role!

  def index
    load_countries
    @filtered_property_owners = PropertyOwner.ransack(params[:search])
    @pagy, @property_owners = pagy(policy_scope(@filtered_property_owners.result.includes(:profile).order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if user_can_approve(@property_owner) && @property_owner.update(update_status_params)
        format.html { redirect_to @property_owner, notice: 'Successfully updated.' }
      else
        format.html { render :show, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_property_owner
    @property_owner = policy_scope(PropertyOwner).find(params[:id])
  end

  def load_countries
    @countries = Country.pluck(:name)
  end

  def update_status_params
    params.require(:property_owner).permit(:audit_comment, :status)
  end
end
