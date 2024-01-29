# frozen_string_literal: true

class Investment < ApplicationRecord
  include Investments

  enum status: { committed_amount: 0, completed: 1, refunded: 2 }
  belongs_to :user
  belongs_to :deal

  has_many :transactions, as: :transactable

  validate :invested_amount_limit
  validates :user_id, uniqueness: { scope: [:deal_id], message: I18n.t('investment.try_again') }

  after_create :update_invite, :create_invested_transaction
  before_update :create_refunded_transaction

  default_scope { self.not_refunded }
  scope :latest_first, -> { order(created_at: :desc) }
  scope :by_property, -> { joins(:deal).where(deal: { deal_type: Deal::deal_types[:property] }) }
  scope :by_startup, -> { joins(:deal).where(deal: { deal_type: Deal::deal_types[:startup] }) }
  scope :filter_by_deal_type, ->(deal_type) { joins(:deal).where(deal: { deal_type: deal_type }) }

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[deals user]
  end

  def net_value
    deal.investment_multiple * amount.to_f
  end

  private

  def invested_amount_limit
    return errors.add(:amount, I18n.t('investment.zero_amount_limit')) if amount <= 0
    return errors.add(:investment_amount, I18n.t('investment.deal_target_limit')) if amount > deal.target
    pending_amount = deal.target - deal.raised
    return errors.add(:investment_amount, I18n.t('investment.pending_amount_limit', pending_amount)) if amount > pending_amount
    return errors.add(:investment_amount, I18n.t('investment.check_size_limit')) if amount < deal.minimum_check_size
  end

  def dublicate_investment
    if Investment.exists?(user_id: user_id, deal_id: deal_id)
      errors.add(:base, I18n.t('investment.once'))
    end
  end

  def update_invite
    invite = deal.invites.investment.find_by(invitee_id: user_id)
    invite.present? && invite.update!(status: Invite::statuses[:invested])
  end
end
