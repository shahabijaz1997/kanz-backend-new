# frozen_string_literal: true

# Questions Modal
class Question < ApplicationRecord
  enum question_type: {
    multiple_choice: 0,
    switch: 1,
    text: 2,
    checkbox: 3,
    number: 4,
    dropdown: 5,
    text_field: 6
  }

  has_many :options, dependent: :destroy
  has_many :users_responses, dependent: :destroy
  has_many :users, through: :users_responses
  has_many :questions_sections, dependent: :destroy
  has_many :sections, through: :questions_sections

  validates :statement, presence: true
  validates :question_type, inclusion: { in: question_types.keys }

  enum kind: QUESTION_KIND
  accepts_nested_attributes_for :options

  scope :individual_accredition, -> { where(kind: QUESTION_KIND[:individual_accredition]).first }
  scope :firm_accredition, -> { where(kind: QUESTION_KIND[:firm_accredition]).first }
  scope :investment_philosophy, -> { where(kind: QUESTION_KIND[:investment_philosophy]) }
end
