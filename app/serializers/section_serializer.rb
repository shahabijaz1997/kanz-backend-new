# frozen_string_literal: true

# Section's json serializer
class SectionSerializer
  include JSONAPI::Serializer
  attributes :id

  attribute :en do |section|
    {
      index: section.index,
      title: section.title,
      description: section.description,
      is_multiple: section.is_multiple,
      button_label: section.button_label,
      questions: QuestionSerializer.new(section.questions).serializable_hash[:data].map { |d| d[:attributes][:en] }
    }
  end

  attribute :ar do |section|
    {
      index: section.index,
      title: section.title_ar,
      description: section.description_ar,
      is_multiple: section.is_multiple,
      button_label: section.button_label_ar,
      questions: QuestionSerializer.new(section.questions).serializable_hash[:data].map { |d| d[:attributes][:ar] }
    }
  end
end
