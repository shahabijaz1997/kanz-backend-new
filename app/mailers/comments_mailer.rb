# frozen_string_literal: true

class CommentsMailer < ApplicationMailer
  def new_comment(comment)
    @user = comment.recipient
    @author = comment.author
    @message = comment.message
    @deal = comment.deal
    mail(to: @user.email, subject: 'New Comment on deal')
  end
end
