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
      add_more_label: section.add_more_label,
      display_card: section.display_card,
      condition: section.condition,
      fields: FieldAttributeSerializer.new(section.fields).serializable_hash[:data].map { |d| d[:attributes][:en] }
    }
  end

  attribute :ar do |section|
    {
      index: section.index,
      title: section.title_ar,
      description: section.description_ar,
      is_multiple: section.is_multiple,
      add_more_label: section.add_more_label_ar,
      display_card: section.display_card,
      condition: section.condition,
      fields: FieldAttributeSerializer.new(section.fields).serializable_hash[:data].map { |d| d[:attributes][:ar] }
    }
  end
end
