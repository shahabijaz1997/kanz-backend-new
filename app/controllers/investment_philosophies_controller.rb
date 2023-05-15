# frozen_string_literal: true

# Investor philosophy
class InvestmentPhilosophiesController < ApplicationController
  def philosophy_question
    if valid_params
      questions = Question.where(step: current_step)
      data = QuestionSerializer.new(questions).serializable_hash[:data].map{ |data| data[:attributes] }
      data = { total_steps: Question.maximum(:step), questions: data }
      success_response("Questions for step: #{current_step}", data)
    else
      unprocessable_request("Can't process this request!")
    end
  end

  def philosophy
    return unprocessable_request if philosophy_params.blank?

    ActiveRecord::Base.transaction do
      philosophy_params[:questions].each do |question|
        philosophy = InvestmentPhilosophy.find_or_create_by(
          question_id: question[:question_id],
          user_id: current_user.id
        )
        philosophy.update!(question)
      end
    end
    success_response("Investment philosophy updated successfully", data={})
  rescue StandardError => e
    unprocessable_request
  end
  
  private
  
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
        :question_id, :answer,
        answer_meta: [:index, :statement, :is_range, :lower_limit, :uper_limit, :unit]
      ]
    )
  end
end
