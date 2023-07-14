# frozen_string_literal: true

module V1
  class AttachmentsController < ApiController
    before_action :set_attachment, only: %i[show update destroy]
    before_action :check_file_presence, only: %i[create]

    # GET /attachments/1
    def show
      render json: @attachment
    end

    # POST /attachments
    def create
      @attachment = current_user.attachments.new(attachment_params)
      @attachment.file.attach(attachment_params[:file])
      if @attachment.save!
        success(
          I18n.t('attachments.upload.success'),
          { attachment_id: @attachment.id, url: @attachment.url }
        )
      else
        failure(@attachment.errors.full_messages.to_sentence)
      end
    end

    # PATCH/PUT /attachments/1
    def update
      if @attachment.parent_id == current_user.id && @attachment.update(attachment_params)
        success(I18n.t('attachments.update.success'))
      else
        failure(I18n.t('attachments.update.failure'))
      end
    end

    # DELETE /attachments/1
    def destroy
      if @attachment.destroy
        success(I18n.t('attachments.delete.success'))
      else
        failure(I18n.t('attachments.delete.failure'))
      end
    end

    # POST /attachments/submit
    def submit
      response = UserState::Manager.call(current_user)
      if response.status
        success(response.message)
      else
        failure(response.message)
      end
    end

    private

    def set_attachment
      @attachment = current_user.attachments.find_by(id: params[:id])

      failure(I18n.t('attachments.not_found')) if @attachment.blank?
    end

    def attachment_params
      params.require(:attachment).permit(:name, :attachment_kind, :file, :attachment_config_id)
    end

    def check_file_presence
      failure(I18n.t('errors.exceptions.file_missing')) if attachment_params[:file].blank?
    end
  end
end
