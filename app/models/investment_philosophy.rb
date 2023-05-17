class InvestmentPhilosophy < Questionnaire
  belongs_to :investor, foreign_key: :user_id, class_name: 'User'
  validates :user_id, uniqueness: { scope: [:question_id] }
end
