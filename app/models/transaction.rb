class Transaction < ApplicationRecord
  belongs_to :wallet

  has_one_attached :receipt
  
  enum transaction_type: %i[deposit withdraw fee refund]
  enum status: %i[pending hold confirmed rejected]
  enum method: %i[offline online]

  after_update :update_wallet, if: :saved_change_to_status?

  audited only: :status, on: %i[update]

  def receipt_url
    Rails.env.development? ? ActiveStorage::Blob.service.path_for(receipt.key) : receipt.url if receipt.attached?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[amount transaction_type method status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['wallet']
  end

  private

  def update_wallet
    unless rejected?
      self.deposit? ? wallet.deposit(amount) : wallet.withdraw(amount)
    end
  end
end
