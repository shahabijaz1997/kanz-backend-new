# frozen_string_literal: true

# Startups apis
module V1
  class DealsController < ApiController
    before_action :find_deal
    def show
      DealSerializer.new(@deal).serializable_hash[:data][:attributes]
    end

    def create
      Deal
    end

    def update
    end

    private

    def find_deal
      @deal = current_user.deals.find_by(params[:id])
    end

    def deal_params
      params.require(:deal).permit()
    end

    def step_params
      params[:step].to_i
    end

    # Use Authorization
    # def verify_user_eligibility
    #   current_user.startup?
    #   current_user.realtor?
    # end
  end
end