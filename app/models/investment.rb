# frozen_string_literal: true

class Investment < ApplicationRecord
  enum status: { committed_amount: 0, completed: 1 }
  belongs_to :user
  belongs_to :deal

  validate :invested_amount_limit
  validates :user_id, uniqueness: { scope: [:deal_id], message: "invest again in same deal" }

  before_save :check_account_balance
  after_create :update_invite

  scope :latest_first, -> { order(created_at: :desc) }

  private

  def check_account_balance
    # Pending Implementation
  end

  def invested_amount_limit
    return errors.add(:amount, 'should be greator that zero') if amount <= 0
    return errors.add(:investment_amount, "can't exceed the deal target") if amount > deal.target
    pending_amount = deal.target - deal.raised
    return errors.add(:investment_amount, "exceedes the target amount, you can invest #{pending_amount} at max") if amount > pending_amount
    return errors.add(:investment_amount, "can't be less than minimum check size" ) if amount < deal.minimum_check_size
  end

  def dublicate_investment
    if Investment.exists?(user_id: user_id, deal_id: deal_id)
      errors.add(:base, 'You can invest once!')
    end
  end

  def update_invite
    invite = deal.invites.investment.find_by(invitee_id: user_id)
    invite.present? && invite.update!(status: Invite::statuses[:invested])
  end
end
