# frozen_string_literal: true

# QuestionsSection Modal
class QuestionsSection < ApplicationRecord
  belongs_to :question
  belongs_to :section
end
