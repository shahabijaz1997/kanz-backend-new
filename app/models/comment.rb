class Comment < ApplicationRecord
  attr_accessor :invite_id, :attachments

  enum state: { pending: 0, read: 1 }
  validates_presence_of :message

  belongs_to :author, class_name: 'User'
  belongs_to :thread, class_name: 'Comment', optional: true
  belongs_to :deal
  belongs_to :recipient, class_name: 'User'
  has_many :replies, class_name: 'Comment', foreign_key: 'thread_id'

  after_create :notify_comment_reader, :update_inivte

  private

  def notify_comment_reader
    CommentsMailer::new_comment(self).deliver_now
  end

  def update_inivte
    return if !author.syndicate? || thread_id.present?

    Invite.mark_as_commented(deal_id, author_id)
  end
end
