# frozen_string_literal: true

class Questionnaire < ApplicationRecord
  belongs_to :question
  belongs_to :respondable, polymorphic: true
  validates :respondable_id, uniqueness: { scope: [:question_id] }
end
