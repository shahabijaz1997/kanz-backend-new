# frozen_string_literal: true

class Activity < ApplicationRecord
  # new deal means live on platform
  enum action: { new_deal: 0,
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

  validates :record_type, :user_type, :new_value, presence: true

  belongs_to :record, polymorphic: true
  belongs_to :user, polymorphic: true

  after_create :add_notifications

  private

  def add_notifications
    Notifications::Base.call(self)
  end
end
