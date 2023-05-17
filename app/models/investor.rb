class Investor < User
  has_many :questionnaires, foreign_key: :user_id
  has_many :questions, through: :questionnaires
  has_many :attachments, as: :parent, dependent: :destroy
end
