# frozen_string_literal: true

# Startups apis
module V1
  class DealsController < ApiController
    before_action :find_deal, only: %i[show review submit documents comments activities sign_off]
    before_action :set_deal, only: %i[create]
    before_action :set_invite, only: %i[sign_off]

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
      success(
        'Success',
        CommentSerializer.new(@deal.comments).serializable_hash[:data].map{|d| d[:attributes]}
      )
    end

    def activities
      # activities = @deal.activities
      # success('Success', activities)
    end

    def submit
      if @deal.update(status: Deal.statuses[:submitted], submitted_at: Time.zone.now, current_state: {})
        DealsMailer::submission(@deal, current_user).deliver_now
        success(@deal)
      else
        failure(@deal.errors.full_messages.to_sentence)
      end
    end

    def overview
      @deal = current_user.deals.find_by(id: params[:id])
      @deal ||= Invite.where(eventable_id: params[:id], eventable_type: 'Deal', invitee: current_user)&.first&.eventable

      if @deal.present?
        success('Success', Deals::Overview.call(@deal, current_user))
      else
        failure('Deal not found', 404)
      end
    end

    def sign_off
      Deal.transaction do
        @invite.update!(status: Invite::statuses[:approved])
        @deal.update!(syndicate: @invite.invitee, status: Deal::statuses[:live])
      end
      success('Success', @deal)
    end

    private

    def find_deal
      @deal = current_user.deals.find_by(id: params[:id])
      failure('Unable to find deal', 404) if  @deal.blank?
    end

    def deal_params
      params.require(:deal).permit(:id, :deal_type, :step, fields: %i[id value index deleted])
    end

    def deal_approval_params
      params.require(:deal).permit(%i[invite_id])
    end

    def set_deal
      return failure(I18n.t('errors.exceptions.parameter_missing')) if deal_params[:id].blank? && invalid_deal_type?

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

    def set_invite
      @invite = @deal.invites.find_by(id: deal_approval_params[:invite_id], status: Invite::statuses[:accepted])
      failure("Invite can't be updated") if @invite.blank?
    end
  end
end
