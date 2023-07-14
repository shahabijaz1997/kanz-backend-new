# frozen_string_literal: true

module QuestionsHelper
  def get_answer(user, question)
    user.investment_philosophies.where(question:).first.try(:answers)&.join(', ')
  end
end
