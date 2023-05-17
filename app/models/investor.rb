class Investor < User
  has_many :questionnaires, as: :respondable
  has_many :questions, through: :questionnaires
  has_many :attachments, as: :parent, dependent: :destroy
end
