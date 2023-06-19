# frozen_string_literal: true

# Question's json serializer
class QuestionSerializer
  include JSONAPI::Serializer
  attributes :id, :step, :index, :required, :question_type

  attribute :en do |q|
    options = q.options['schema'].map do |option|
      option.except('statement_ar')
    end

    {
      category: q.category,
      title: q.title,
      statement: q.statement,
      description: q.description,
      options: options
    }
  end

  attribute :ar do |q|
    options = q.options['schema'].map do |option|
      option.except('statement')
      option['statement'] = option.delete 'statement_ar'
      option
    end

    {
      category: q.category_ar,
      title: q.title_ar,
      statement: q.statement_ar,
      description: q.description_ar,
      options: options
    }
  end
end
