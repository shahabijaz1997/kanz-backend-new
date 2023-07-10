# frozen_string_literal: true

class Investor < User
  has_many :investment_philosophies, class_name: 'UsersResponse', foreign_key: :user_id, dependent: :destroy,
                                     inverse_of: :user
  has_many :questions, through: :users_responses
  has_one :profile, class_name: 'InvestorProfile', dependent: :destroy

  def individual_investor?
    role_title == 'Individual Investor'
  end

  def investment_firm?
    role_title == 'Investment Firm'
  end
end
