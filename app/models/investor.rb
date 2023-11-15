# frozen_string_literal: true

class Investor < User
  has_many :investment_philosophies, class_name: 'UsersResponse', foreign_key: :user_id, dependent: :destroy,
                                     inverse_of: :user
  has_many :questions, through: :users_responses
  has_one :profile, class_name: 'InvestorProfile', dependent: :destroy
  has_many :syndicate_members, as: :member, dependent: :destroy

  scope :individuals, -> { where(user_role: Role.find_by(title: 'Individual Investor')) }
  scope :firms, -> { where(user_role: Role.find_by(title: 'Investment Firm')) }

  def individual_investor?
    role_title == 'Individual Investor'
  end

  def investment_firm?
    role_title == 'Investment Firm'
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['profile']
  end
end
