# frozen_string_literal: true

# Question's json serializer
class FieldAttributeSerializer
  include JSONAPI::Serializer

  attribute :en do |q|
    {
      id: q.id,
      index: q.index,
      is_required: q.is_required,
      field_type: q.field_type,
      statement: q.statement,
      description: q.label,
      description: q.description,
      suggestions: q.suggestions,
      permitted_types: q.permitted_types,
      size_constraints: q.size_constraints,
      options: OptionSerializer.new(q.options).serializable_hash[:data].map { |d| d[:attributes][:en] },
      dependency: DependencyTreeSerializer.new(q.dependencies).serializable_hash[:data].map { |d| d[:attributes] }
    }
  end

  attribute :ar do |q|
    {
      id: q.id,
      index: q.index,
      is_required: q.is_required,
      field_type: q.field_type,
      statement: q.statement_ar,
      description: q.label_ar,
      description: q.description_ar,
      suggestions: q.suggestions,
      permitted_types: q.permitted_types,
      size_constraints: q.size_constraints,
      options: OptionSerializer.new(q.options).serializable_hash[:data].map { |d| d[:attributes][:ar] },
      dependency: DependencyTreeSerializer.new(q.dependencies).serializable_hash[:data].map { |d| d[:attributes] }
    }
  end
end
