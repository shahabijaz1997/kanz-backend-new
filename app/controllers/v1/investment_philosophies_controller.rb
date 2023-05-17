# frozen_string_literal: true

# Investor philosophy
class V1::InvestmentPhilosophiesController < ApplicationController
  before_action :validate_persona

  def philosophy_question
    if valid_params
      questions = Question.where(step: current_step)
      questions = QuestionSerializer.new(questions).serializable_hash[:data].map{ |data| data[:attributes] }
      data = { total_steps: Question.maximum(:step), questions: questions }
      success("Questions for step: #{current_step}", data)
    else
      unprocessable("Can't process this request!")
    end
  end

  def philosophy
    return unprocessable if philosophy_params.blank?
    ActiveRecord::Base.transaction do
      philosophy_params[:questions].each do |question|
        questionnaire = Questionnaire.find_or_create_by(
          question_id: question[:question_id],
          respondable_id: current_user.id,
          respondable_type: 'Investor'
        )
        questionnaire.update!(question)
      end
    end
    success("Investment philosophy updated successfully", data={})
  rescue StandardError => e
    unprocessable
  end
  
  private

  def validate_persona
    unprocessable unless current_user.investor?
  end
  
  def valid_params
    return false if params[:step].blank?

    last_step = Question.maximum(:step)
    return current_step <= last_step && current_step >= 1
  end

  def current_step
    params[:step].to_i
  end

  def philosophy_params
    params.require(:investment_philosophy).permit(
      :step,
      questions: [
        :question_id,
        answers: [],
        answer_meta: [options: [:index, :statement, :is_range, :lower_limit, :uper_limit, :unit]]
      ]
    )
  end
end
