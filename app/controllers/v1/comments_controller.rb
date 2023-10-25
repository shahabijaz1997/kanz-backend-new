# frozen_string_literal: true

module V1
  class CommentsController < ApiController
    before_action :find_deal, only: %i[index show create]
    before_action :find_deal_comment, only: %i[show]

    def index
      success(
        'success',
        CommentSerializer.new(@deal.comments).serializable_hash[:data].map{ |d| d[:attributes] }
      )
    end

    def show
      success(
        'success',
        CommentSerializer.new(@comment).serializable_hash[:data][:attributes]
      )
    end

    # /1.0/deals/:deal_id/comments
    def create
      comment = current_user.comments.build(comment_params.merge(deal_id: @deal.id, recipient_id: recipient_id))
      StartupProfile.transaction do
        update_deal
        update_inivte
        upload_attachments
        comment.save!
      end
      success('success', comment)
    end

    private

    def comment_params
      params.require(:comment).permit(:message, :thread_id, :invite_id, attachments: %i[file attachment_kind])
    end

    def find_deal
      @deal = Deal.find_by(id: params[:deal_id])

      return failure('Deal not found') if @deal.blank?
    end

    def find_deal_comment
      @comment = @deal.comments.find_by(id: id)

      return failure('Comment not found') if @comment.blank?
    end

    def recipient_id
      if comment_params[:thread_id].present?
        Comment.find_by(id: comment_params[:thread_id])&.id
      else
        @deal.author_id
      end
    end

    def update_inivte
      return true if comment_params[:invite_id].present?

      invite = @deal.invites.find_by(id: comment_params[:invite_id])
      invite.update!(status: Invite::statuses[:interested])
    end

    def update_deal
      @deal.update!(status: Deal::statuses[:reopened])
    end

    def upload_attachments
      return true if comment_params[:attachments].blank?

      comment_params[:attachments].each do |attachment|
        @deal.attachments.create!(attachment.merge(uploaded_by: current_user))
      end
    end
  end
end
