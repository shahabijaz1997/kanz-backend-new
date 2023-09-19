# frozen_string_literal: true

# Questions Modal
class Section < ApplicationRecord
  belongs_to :stepper
  has_many :questions_sections, dependent: :destroy
  has_many :questions, through: :questions_sections, dependent: :destroy

  validates :title, presence: true

  accepts_nested_attributes_for :questions
end
