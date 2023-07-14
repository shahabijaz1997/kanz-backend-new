# frozen_string_literal: true

# Question's json serializer
class QuestionSerializer
  include JSONAPI::Serializer
  attributes :id, :step, :index, :required, :question_type, :answer

  attribute :en do |q|
    {
      category: q.category,
      title: q.title,
      statement: q.statement,
      description: q.description,
      options: OptionSerializer.new(q.options).serializable_hash[:data].map { |d| d[:attributes][:en] }
    }
  end

  attribute :ar do |q|
    {
      category: q.category_ar,
      title: q.title_ar,
      statement: q.statement_ar,
      description: q.description_ar,
      options: OptionSerializer.new(q.options).serializable_hash[:data].map { |d| d[:attributes][:ar] }
    }
  end
end
