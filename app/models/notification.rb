# frozen_string_literal: true

class Notification < ApplicationRecord
  enum status: { pending_read: 0, read: 1 }
  enum kind: { new_deal: 0,
               syndication_invite: 1,
               syndication_request: 2,
               syndicate_assigned: 3,
               syndicate_membership_invite: 4,
               syndicate_membership_request: 5,
               syndicate_membership: 6,
               investment_invite: 7,
               new_investment: 8,
               investment_refunded: 9,
               deal_closed: 10,
               deal_valuation_changed: 11,
               rental_amount_changed: 12,
               rental_cycle_changed: 13,
               valuation_phase_changed: 14,
               deal_update_published: 15 }

  belongs_to :activity
  belongs_to :recipient, class_name: 'User'

  validates :message, :message_ar, presence: true

  scope :latest_first, -> { order(created_at: :desc) }

  def localized_message
    I18n.locale == :en ? message : message_ar
  end
end
