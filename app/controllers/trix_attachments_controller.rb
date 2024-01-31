class TrixAttachmentsController < ApplicationController
  def create
    @attachment = current_user.attachments.new(attachment_params)
    @attachment.uploaded_by = current_user

    respond_to do |format|
      if @attachment.save
        format.json { render json: { url: @attachment.url }.to_json, status: :created }
      else
        format.json { render json: @attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file)
  end

end

