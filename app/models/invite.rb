class Invite < ApplicationRecord
  after_initialize :set_defaults

  belongs_to :eventable, polymorphic: true, optional: true
  belongs_to :user
  belongs_to :invitee, class_name: 'User'

  validates_uniqueness_of :invitee_id, scope: %i[eventable_type eventable_id]

  enum status: { pending: 0, ignored: 1, accepted: 2, expired: 3 }

  before_update :validate_status_change

  def set_defaults
    self.expire_at = Time.zone.now + 7.days
  end

  def validate_status_change
    if status_was != 'pending'
      errors[:base] << 'Only pending invites can be updated'
    end
  end
end
