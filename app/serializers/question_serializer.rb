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
    options = q&.options.try(:[], 'schema')&.map do |option|
      option.except('statement_ar')
    end

    {
      category: q.category,
      title: q.title,
      statement: q.statement,
      description: q.description,
      answer: q.try(:answer),
      options:
    }
  end

  attribute :ar do |q|
    options = q&.options.try(:[], 'schema')&.map do |option|
      option.except('statement')
      option['statement'] = option.delete 'statement_ar'
      option
    end

    {
      category: q.category_ar,
      title: q.title_ar,
      statement: q.statement_ar,
      description: q.description_ar,
      answer: q.try(:answer),
      options:
    }
  end

  def append_answer(question, user_response)
    answers = user_response.answers
    if question.question_type.in?(["multiple_choice", "checkbox"])
      options = question.options["schema"].map do |option|
        option.merge("selected" => option["statement"].in?(answers) || option["statement_ar"].in?(answers))
      end
      question.options["schema"] = options
    elsif question.question_type == 'text'
      Question.class_eval { attr_accessor 'answer' }
      question.instance_variable_set "@answer", answers.first
    end
    question
  end
end
