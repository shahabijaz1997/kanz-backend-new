class Invite < ApplicationRecord
  after_initialize :set_defaults

  belongs_to :eventable, polymorphic: true, optional: true
  belongs_to :user
  belongs_to :invitee, class_name: 'User'

  validates_uniqueness_of :invitee_id, scope: %i[eventable_type eventable_id]

  enum status: { pending: 0, interested: 1, accepted: 2, approved: 3, expired: 4, invested: 5 }
  enum purpose: { syndication: 0, investment: 1, syndicate_membership: 2 }

  before_update :validate_status_change
  # after_create :send_invite_email
  after_commit :send_invite_email, on: :create
  after_update :send_status_update_email

  scope :latest_first, -> { order(created_at: :desc) }
  scope :active, -> { where.not(status: Invite::statuses[:expired]) }
  scope :pending, -> { where(status: Invite::statuses[:pending]) }
  scope :interested_invites, -> { where(status: %i[interested accepted approved]) }
  scope :by_status, -> (status) { where(status: status) }

  def expired?
    expire_at < Time.zone.now
  end

  def self.mark_as_commented(deal_id, comment_creator_id, comment_recipient_id)
    invite = find_or_create_by(
      user_id: comment_recipient_id,
      eventable_type: 'Deal',
      eventable_id: deal_id,
      invitee_id: comment_creator_id
    )
    invite.update!(status: statuses[:interested])
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[eventable_type]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[eventable user invitee]
  end

  private

  def set_defaults
    self.expire_at = Time.zone.now + 7.days
  end

  def validate_status_change
    return if status_was == 'pending'

    errors[:base] << I18n.t('invite.invite_update_condition')
  end

  def send_invite_email
    InvitesMailer::new_invite(self).deliver_now
  end

  def send_status_update_email
    return if status == 'approved' || status == 'invested'

    InvitesMailer.invite_update(self).deliver_now
  end
end
