# frozen_string_literal: true

class Investment < ApplicationRecord
  enum status: { committed_amount: 0, completed: 1 }
  belongs_to :user
  belongs_to :deal

  before_save :check_account_balance

  scope :latest_first, -> { order(created_at: :desc) }

  private

  def check_account_balance
  end
end
