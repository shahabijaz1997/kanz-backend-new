# frozen_string_literal: true

# Startups apis
module V1
  class DealsController < ApiController
    before_action :find_deal, only: %i[show review submit overview documents comments activities]
    before_action :set_deal, only: %i[create]

    def index
      deals = if current_user.syndicate?
        Deal.syndicate_deals.latest_first
      else
        current_user.deals.latest_first
      end

      deals = DealSerializer.new(deals).serializable_hash[:data].map do |d|
        simplify_deal_attributes(d[:attributes])
      end
      success('success', deals)
    end

    def show
      deal = DealSerializer.new(@deal).serializable_hash[:data][:attributes]
      success('success', simplify_deal_attributes(deal))
    end

    def create
      response = Deals::ParamComposer.call(deal_params, @deal)
      failure(response.message) unless response.status

      if @deal.update(response.data)
        success('success', { id: @deal.id })
      else
        failure(@deal.errors.full_messages.to_sentence)
      end
    end

    def review
      @steppers = Stepper.where(stepper_type: STEPPERS[params[:type].to_sym]).order(:index)
      steps = Settings::ParamsMapper.call(@deal, @steppers, true)
      success('Success', steps)
    end

    def documents
      docs = AttachmentSerializer.new(@deal.attachments).serializable_hash[:data].map { |d| d[:attributes] }
      success('Success', docs)
    end

    def comments
      # comments = @deal.comments
      # success('Success', comments)
    end

    def activities
      # activities = @deal.activities
      # success('Success', activities)
    end

    def submit
      if @deal.update(status: Deal.statuses[:submitted], submitted_at: Time.zone.now)
        DealsMailer::submission(@deal, current_user).deliver_now
        success(@deal)
      else
        failure(@deal.errors.full_messages.to_sentence)
      end
    end

    def overview
      success('Success', Deals::Overview.call(@deal))
    end

    private

    def find_deal
      @deal = current_user.deals.find_by(id: params[:id])
    end

    def deal_params
      params.require(:deal).permit(:id, :deal_type, :step, fields: %i[id value index deleted])
    end

    def set_deal
      return failure(I18n.t('errors.exceptions.paramete_missing')) if deal_params[:id].blank? && invalid_deal_type?

      @deal = current_user.deals.find_by(id: deal_params[:id])
      @deal = @deal || current_user.deals.new(deal_type: deal_params[:deal_type])
    end

    def invalid_deal_type?
      deal_params[:deal_type].blank? || DEAL_TYPES[deal_params[:deal_type].to_sym].blank?
    end

    def simplify_deal_attributes(attributes)
      return attributes if attributes[:details].blank?

      attributes = attributes.merge(attributes[:details])
      attributes.delete(:details)
      attributes
    end
  end
end
