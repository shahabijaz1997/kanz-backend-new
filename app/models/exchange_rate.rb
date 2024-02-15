class ExchangeRate < ApplicationRecord
  before_save :mark_current

  scope :current, -> { where(current: true).last }

  def mark_current
    ExchangeRate.where.not(id: self.id).update_all(current: false)
  end
end
