# frozen_string_literal: true

class Investor < User
  has_many :investment_philosophies, class_name: 'UsersResponse', foreign_key: :user_id, dependent: :destroy,
                                     inverse_of: :user
  has_many :questions, through: :users_responses
  has_one :profile, class_name: 'InvestorProfile', dependent: :destroy

  scope :individuals, -> { where(role_id: 1) }
  scope :firms, -> { where(role_id: 2) }

  def firm?
    role_id == 2
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(auth_object = nil)
    ['profile']
  end
end
