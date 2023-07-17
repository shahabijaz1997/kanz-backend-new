# frozen_string_literal: true

module QuestionsHelper
  def get_answer(user, question)
    answer = user.investment_philosophies.find_by(question_id: question.id)
    return '' if answer.blank?
    return answer.answer if question.question_type == 'text'

    Option.where(id: answer.selected_option_ids).pluck(:statement)&.join(', ')
  end
end
