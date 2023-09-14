# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :question
  validates :statement, :index, presence: true
  validates :statement, uniqueness: { scope: :question_id }
end
