class Questionnaire < ApplicationRecord
  belongs_to :question
  belongs_to :investor, foreign_key: :user_id, class_name: 'User'
  validates :user_id, uniqueness: { scope: [:question_id] }
end
