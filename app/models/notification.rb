class Notification < ApplicationRecord
  enum status: %i[pending_read read]
  enum kind: %i[new_deal
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

  belongs_to :activity
  belongs_to :recipient, class_name: 'User'

  validates :message, :message_ar, presence: true

  scope :latest_first, -> { order(created_at: :desc) }

  def localized_message
    I18n.locale == :en ? message : message_ar
  end
end
