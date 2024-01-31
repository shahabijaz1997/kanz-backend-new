class Transaction < ApplicationRecord
  belongs_to :wallet
  belongs_to :transactable, polymorphic: true, optional: true

  has_one_attached :receipt
  
  enum transaction_type: %i[credit debit fee]
  enum status: %i[pending invested confirmed rejected refunded deducted]
  enum method: %i[offline online]

  after_save :update_wallet

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
    if [:invested, :confirmed, :refunded, :deducted].include?(status.to_sym)
      self.debit? ? wallet.withdraw(amount) : wallet.deposit(amount)
    end
  end
end
