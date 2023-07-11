# frozen_string_literal: true

# Question's json serializer
class QuestionSerializer
  include JSONAPI::Serializer
  attributes :id, :step, :index, :required, :question_type

  def initialize(questions, user)
    questions_with_response = questions.map do |question|
      user_response = UsersResponse.find_by(question_id: question.id, user_id: user.id)
      user_response.present? ? append_answer(question, user_response) : question
    end

    super(questions_with_response)
  end

  attribute :en do |q|
    {
      category: q.category,
      title: q.title,
      statement: q.statement,
      description: q.description,
      answer: q.try(:answer),
      options: OptionSerializer.new(q.options).serializable_hash[:data].map { |d| d[:attributes][:en] }
    }
  end

  attribute :ar do |q|
    {
      category: q.category_ar,
      title: q.title_ar,
      statement: q.statement_ar,
      description: q.description_ar,
      answer: q.try(:answer),
      options: OptionSerializer.new(q.options).serializable_hash[:data].map { |d| d[:attributes][:ar] }
    }
  end

  def append_answer(question, user_response)
    answers = user_response.answers
    if question.question_type.in?(["multiple_choice", "checkbox"])
      options = question.options.map do |option|
        option.class_eval { attr_accessor 'selected' }
        question.instance_variable_set "@selected", option.id.in?(answers)
      end
      question.options = options
    elsif question.question_type == 'text'
      Question.class_eval { attr_accessor 'answer' }
      question.instance_variable_set "@answer", answers.first
    end
    question
  end
end
