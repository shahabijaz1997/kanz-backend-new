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
    Deal.transaction do
      ActivityRecorder::Deal.call(deal_update_params, @deal, current_user)
      @deal.update!(deal_update_params)
      redirect_to deal_path, notice: 'Successfully updated.'
    end
  rescue Exception => e
    raise e
    redirect_to deal_path, alert: e.message
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
                                 funding_round_attributes: %i[id valuation valuation_phase_id],
                                 property_detail_attributes: %i[id rental_amount rental_period_id])
  end

  def deals_path
    @deal.startup? ? start_up_index_path : property_index_path
  end

  def deal_path
    @deal.startup? ? start_up_path(@deal) : property_path(@deal)
  end
end
