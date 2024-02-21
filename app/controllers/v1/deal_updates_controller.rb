module V1
  class DealUpdatesController < ApiController
    before_action :set_deal_update, only: %i[update show]

    # GET /v1/deal_updates/1
    def show
      success(
        I18n.t('deal_update.success'),
        DealUpdateSerializer.new(@deal_update).serializable_hash[:data][:attributes]
      )
    end

    # POST /v1/deal_updates
    def create
      @deal_update = current_user.deal_updates.new(deal_update_params)

      if @deal_update.save
        success(
          I18n.t('deal_update.success'),
          DealUpdateSerializer.new(@deal_update).serializable_hash[:data][:attributes]
        )
      else
        failure(@deal_update.errors.full_messages.to_sentence)
      end
    end

    # PATCH/PUT /v1/deal_updates/1
    def update
      if @deal_update.update(deal_update_params)
        success(
          I18n.t('deal_update.success'),
          DealUpdateSerializer.new(@deal_update.reload).serializable_hash[:data][:attributes]
        )
      else
        failure(@deal_update.errors.full_messages.to_sentence)
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_deal_update
      @deal_update = DealUpdate.find(params[:id])
      failure(I18n.t('deal_update.not_found')) if @deal_update.blank?
    end

    # Only allow a list of trusted parameters through.
    def deal_update_params
      params.require(:deal_update).permit(:description, :deal_id, :report)
    end
  end
end
