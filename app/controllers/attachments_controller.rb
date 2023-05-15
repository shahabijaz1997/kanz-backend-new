# frozen_string_literal: true

class AttachmentsController < ApplicationController
	before_action :set_attachment, only: [ :show, :update, :destroy ]

  # GET /attachments/1
  def show
    render json: @attachment
  end

  # POST /attachments
  def create
    @attachment = current_user.attachments.new(attachment_params)

    if !params[:files].nil? && params[:files].length() > 0
      @attachment.files.attach(params[:files])
    end

    if @attachment.valid_files? && @attachment.save!
      render json: @attachment, status: :created, location: @attachment
    else
      render json: @attachment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attachments/1
  def update
    if @attachment.parent_id == current_user.id && @attachment.update(attachment_params)
      render json: @attachment
    else
      render json: @attachment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attachments/1
  def destroy
    if @attachment.parent_id == current_user.id
      @attachment.destroy
    else
      head :forbidden
    end
  end

	private

	def set_attachment
    @attachment = current_user.attachments.find(params[:id])
	end

	def attachment_params
		params.require(:attachment).permit(:name, :attachment_kind, files: [])
	end
end
