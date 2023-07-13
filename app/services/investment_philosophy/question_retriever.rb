# frozen_string_literal: true

module InvestmentPhilosophy
  class QuestionRetriever < ApplicationService
    attr_reader :step, :user

    def initialize(step = nil, user)
      @step = step.to_i
      @last_step = Question.maximum(:step)
      @user = user
    end

    def call
      return response(I18n.t('investor.get.failure.step'), false) unless valid_step?

      questions = fetch_questions
      return response(I18n.t('investor.get.failure.no_question'), false) if questions.blank?

      response(
        I18n.t('investor.get.success.questions',step: step),
        true,
        { total_steps: @last_step, questions: questions},
        200
      )
    end

    private

    def valid_step?
      step <= @last_step && step >= 1
    end

    def fetch_questions
      questions = Question.where(step:)
      return [] if questions.blank?

      QuestionSerializer.new(questions).serializable_hash[:data].map do |data|
        users_answer = user.investment_philosophies.find_by(question_id: data[:attributes][:id])
        return data[:attributes] if users_answer.blank?

        if data[:attributes][:question_type].in? ['multiple_choice', 'checkbox']
          data[:attributes][:en][:options].map do |opt|
            opt[:selected] = true if opt[:id].in? users_answer.selected_option_ids
            opt
          end
          data[:attributes][:ar][:options].map do |opt|
            opt[:selected] = true if opt[:id].in? users_answer.selected_option_ids
            opt
          end
        end
        data[:attributes][:en][:answer] = users_answer.answer
        data[:attributes]
      end
    end
  end
end
