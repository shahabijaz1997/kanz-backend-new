# frozen_string_literal: true

module InvestmentPhilosophy
  class QuestionRetriever < ApplicationService
    attr_reader :step

    def initialize(step = nil)
      @step = step.to_i
      @last_step = Question.maximum(:step)
    end

    def call
      return response('Provide valid steps', false) unless valid_step?

      questions = fetch_questions
      return response('No questions found for provided step', false) if questions.blank?

      response(
        message: "Questions for step: #{step}",
        status: true,
        data: { total_steps: @last_step, questions: },
        code: 200
      )
    end

    private

    def valid_step?
      step <= @last_step && step >= 1
    end

    def fetch_questions
      questions = Question.where(step:)
      return [] if questions.blank?

      QuestionSerializer.new(questions).serializable_hash[:data].pluck(:attributes)
    end
  end
end
