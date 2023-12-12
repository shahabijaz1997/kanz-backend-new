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
      comment.save ? success('success', comment) : failure(comment.errors.full_messages.to_sentence)
    end

    private

    def comment_params
      params.require(:comment).permit(:message, :thread_id, :invite_id)
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
      return @deal.author_id if @deal.user != current_user

      comment = Comment.find_by(id: comment_params[:thread_id])
      author_id = comment&.author_id == current_user.id ? comment&.recipient_id : comment&.thread_id
      author_id || @deal.invites.find_by(id: comment_params[:invite_id])&.invitee_id
    end
  end
end
