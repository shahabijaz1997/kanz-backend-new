# frozen_string_literal: true

module V1
  class AttachmentsController < ApplicationController
    before_action :set_attachment, only: %i[show update destroy]

    # GET /attachments/1
    def show
      render json: @attachment
    end

    # POST /attachments
    def create
      @attachment = current_user.attachments.new(attachment_params)

      @attachment.file.attach(attachment_params[:file])if attachment_params[:file].present?
      @attachment.name = attachment_params[:name]
      if @attachment.save!
        success(I18n.t('attachments.upload.success'), { attachment_id: @attachment.id })
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
      if @attachment.parent_id == current_user.id
        @attachment.destroy
        success(I18n.t('attachments.delete.success'))
      else
        failure(I18n.t('attachments.delete.failure'))
      end
    end

    private

    def set_attachment
      @attachment = current_user.attachments.find(params[:id])
    end

    def attachment_params
      params.require(:attachment).permit(:name, :attachment_kind, :file)
    end
  end
end
