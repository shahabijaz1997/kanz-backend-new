class DealUpdatesController < ApplicationController
  before_action :find_deal_update, only: %i[publish]

  def publish
    if @deal_update.update(status: :published)
      ActivityRecorder::Deal.call(deal_update_params, @deal, current_user)
      redirect_to deal_path(@deal_update.deal), notice: 'Deal update published'
    else
      redirect_to deal_path(@deal_update.deal), alert: @deal_update.errors.full_messages.to_sentence
    end
  end

  private 

  def find_deal_update
    @deal_update = DealUpdate.find_by(id: params[:id])
  end

  def deal_path(deal)
    deal.startup? ? start_up_path(deal) : property_path(deal)
  end
end
