# frozen_string_literal: true

class Activity < ApplicationRecord
  # new deal means live on platform
  enum actions: %i[new_deal
                   syndication_invite
                   syndication_request
                   syndicate_assigned
                   syndicate_membership_invite
                   syndicate_membership_request
                   syndicate_membership
                   investment_invite
                   new_investment
                   investment_refunded
                   deal_closed
                   deal_valuation_changed
                   rental_amount_changed
                   rental_cycle_changed
                   valuation_phase_changed
                   deal_update_published]

  validates :record_id, :record_type, :user_id, :user_type, :new_value, presence: true

  belongs_to :record, polymorphic: true
  belongs_to :user, polymorphic: true

  after_create :add_notifications

  private

  def add_notifications
    Notifications::Base.call(self)
  end
end
