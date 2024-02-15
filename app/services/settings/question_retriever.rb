# frozen_string_literal: true

module Settings
  class QuestionRetriever < ApplicationService
    attr_reader :step, :user, :kind

    def initialize(step = nil, user, kind)
      @step = step.to_i
      @kind = QUESTION_KIND[kind.to_sym]
      @last_step = Question.where(kind: @kind).maximum(:step)
      @user = user
    end

    def call
      return response('Invalid params for question type') unless valid_kind?
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

    def valid_kind?
      !kind.nil?
    end

    def fetch_questions
      questions = Question.where(kind:, step:)
      return [] if questions.blank?

      QuestionSerializer.new(questions).serializable_hash[:data].map do |data|
        users_answer = user.investment_philosophies.find_by(question_id: data[:attributes][:id])
        data[:attributes] = data_with_answers(data[:attributes], users_answer) if users_answer.present?
        data[:attributes][:answer] = users_answer&.answer
        data[:attributes]
      end
    end

    def data_with_answers(data, users_answer)
      return data unless data[:question_type].in? ['multiple_choice', 'checkbox']

      selected_options = users_answer.selected_option_ids
      data[:en][:options].map do |opt|
        opt[:selected] = (opt[:id].in? selected_options)
        opt
      end

      data[:ar][:options].map do |opt|
        opt[:selected] = (opt[:id].in? selected_options)
        opt
      end
      data
    end
  end
end
