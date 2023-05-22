# frozen_string_literal: true

# Questions Modal
class Question < ApplicationRecord
  enum question_type: {
    multiple_choice: 0,
    true_false: 1,
    text: 2,
    checkbox: 3
  }

  has_many :questionnaires
  has_many :investors, through: :questionnaires

  validates :statement, presence: true
  validates :question_type, inclusion: { in: question_types.keys }
end
