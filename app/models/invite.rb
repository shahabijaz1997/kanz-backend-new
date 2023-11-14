class Invite < ApplicationRecord
  after_initialize :set_defaults

  belongs_to :eventable, polymorphic: true, optional: true
  belongs_to :user
  belongs_to :invitee, class_name: 'User'

  validates_uniqueness_of :invitee_id, scope: %i[eventable_type eventable_id]

  enum status: { pending: 0, interested: 1, accepted: 2, approved: 3, expired: 4 }

  before_update :validate_status_change
  after_create :send_invite_email
  after_update :send_status_update_email

  scope :latest_first, -> { order(created_at: :desc) }
  scope :active, -> { where.not(status: Invite::statuses[:expired]) }
  scope :pending, -> { where(status: Invite::statuses[:pending]) }
  scope :interested, -> { where(status: %i[interested accepted approved]) }
  scope :by_status, -> (status) { where(status: status) }

  def expired?
    expire_at < Time.zone.now
  end

  def self.mark_as_commented(deal_id, comment_creator_id, comment_recipient_id)
    invite = find_by(eventable_type: 'Deal', eventable_id: deal_id, invitee_id: comment_creator_id)
    invite ||= create!(eventable_type: 'Deal', eventable_id: deal_id, user_id: comment_creator_id, invitee_id: comment_recipient_id)
    invite.update!(status: statuses[:interested])
  end

  private

  def set_defaults
    self.expire_at = Time.zone.now + 7.days
  end

  def validate_status_change
    return if status_was == 'pending'

    errors[:base] << 'Only pending invites can be updated'
  end

  def send_invite_email
    InvitesMailer::new_invite(self).deliver_now
  end

  def send_status_update_email
    return if status == 'approved'

    InvitesMailer.invite_update(self).deliver_now
  end
end
