# frozen_string_literal: true

class DealsController < ApplicationController
  include Informer

  before_action :set_deal, except: %i[index]
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

  def close
    Deal.transaction do
      @deal.update!(deal_close_params)
      DealClosingModel::Base.call(@deal)

      if @deal.adjust_pro_rata? || @deal.fifs?
        @step = SPV_FIRST_STEP
        @spv = @deal.spv || Spv.new(deal_id: @deal.id, closing_model:  @deal.closing_model, step: SPV_FIRST_STEP)
        render turbo_stream: turbo_stream.append('spv-modal', partial: 'spvs/new')
      else
        redirect_to deals_path, notice: 'Successfully updated.'
      end
    end
  end

  def extend
    respond_to do |format|
      if @deal.update(deal_extend_params)
        format.html { redirect_to @deal, notice: 'Successfully updated.' }
      else
        format.html { redirect_to deal_path(@deal), alert: @deal.errors.full_messages.to_sentence }
      end
    end
  end

  def valuation_update
    path = @deal.startup? ? start_up_path(@deal) : property_path(@deal)
    if @deal.update(deal_update_params)
      #field_name = deal_update_params
      # @deal.activities.create(user: current_user,
      #                         field_name: field_name,
      #                         old_value: old_value,
      #                         new_value: new_value)
      DealActivityRecorder.call()
      redirect_to path, notice: 'Successfully updated.'
    else
      redirect_to path, alert: @deal.errors.full_messages.to_sentence
    end
  end

  private

  def upload_attachments
    attachment_attributes&.each do |attachment|
      @deal.attachments.create(attachment_kind: attachment.content_type, file: attachment, uploaded_by: current_user)
    end
  end

  def set_deal
    params[:id] ||= params[:deal_id]
    @deal = policy_scope(Deal).find(params[:id])
  end

  def update_status_params
    params.require(:deal).permit(:audit_comment, :model, :status, :closing_model, :end_at)
  end

  def attachment_attributes
    params.require(:deal).permit(attachments: [])[:attachments]
  end

  def deal_close_params
    params.require(:deal).permit(:audit_comment, :status, :closing_model)
  end

  def deal_extend_params
    params.require(:deal).permit(:audit_comment, :end_at)
  end

  def deal_update_params
    params.require(:deal).permit(:target,
                                 funding_round_attributes: %i[valuation valuation_phase],
                                 property_detail_attributes: %i[rental_amount rental_duration])
  end

  def deals_path
    @deal.startup? ? start_up_index_path : property_index_path
  end
end
