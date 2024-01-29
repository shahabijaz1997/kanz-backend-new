class Wallet < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def deposit(amount)
    self.balance += amount
    self.save
  end
  
  def withdraw(amount)
    raise I18n.t('wallet.low_balance') if amount > self.balance

    self.balance -= amount
    self.save
  end

  def self.ransackable_attributes(auth_object = nil)
    ["user_id"]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['user']
  end
end
