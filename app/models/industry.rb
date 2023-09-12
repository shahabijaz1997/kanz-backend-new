class Industry < ApplicationRecord
  has_many :profiles_industries, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[id]
  end
end
