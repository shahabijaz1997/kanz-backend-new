class Transaction < ApplicationRecord
  belongs_to :wallet

  has_one_attached :receipt
  
  enum transaction_type: %i[deposit withdraw fee refund]
  enum status: %i[pending hold confirmed rejected]
  enum method: %i[offline online]
 
end
