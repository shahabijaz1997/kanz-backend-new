class Investor < User
  has_many :investment_philosophies, foreign_key: :user_id
  has_many :questions, through: :investment_philosophies
end
