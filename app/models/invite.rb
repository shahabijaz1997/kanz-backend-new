class Invite < ApplicationRecord
  after_initialize :set_defaults

  belongs_to :eventable, polymorphic: true, optional: true
  belongs_to :user
  belongs_to :invitee, class_name: 'User'

  enum status: { pending: 0, ignored: 1, accepted: 2, expired: 3 }

  def set_defaults
    self.expire_at = Time.zone.now + 7.days
  end
end
