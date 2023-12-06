# frozen_string_literal: true

class DealsController < ApplicationController
  include Informer

  before_action :set_deal, only: %i[show update]
  before_action :authorize_role!

  def index
    @filtered_deals = Deal.send(params[:type].split('_').join('')).ransack(params[:search])
    @pagy, @deals = pagy(policy_scope(@filtered_deals.result.order(created_at: :desc)))
  end

  def show; end

  def update
    respond_to do |format|
      if user_can_approve(@deal) && @deal.update(update_status_params)
        inform_deal_creator
        upload_attachments
        format.html { redirect_to @deal, notice: 'Successfully updated.' }
      else
        format.html { redirect_to deal_path(@deal), alert: @deal.errors.full_messages.to_sentence }
      end
    end
  end

  private

  def upload_attachments
    attachment_attributes&.each do |attachment|
      @deal.attachments.create(attachment_kind: attachment.content_type, file: attachment, uploaded_by: current_user)
    end
  end

  def set_deal
    @deal = policy_scope(Deal).find(params[:id])
  end

  def update_status_params
    params.require(:deal).permit(:audit_comment, :model, :status)
  end

  def attachment_attributes
    params.require(:deal).permit(attachments: [])[:attachments]
  end
end
