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

  def expired?
    expire_at < Time.zone.now
  end

  def self.mark_as_commented(deal_id, invitee_id)
    invite = find_by!(eventable_type: 'Deal', eventable_id: deal_id, invitee_id: invitee_id)
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
