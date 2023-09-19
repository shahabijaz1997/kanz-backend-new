# frozen_string_literal: true

# Stepper's json serializer
class StepperSerializer
  include JSONAPI::Serializer
  attributes :id, :index

  attribute :en do |step|
    {
      title: step.title,
      sections: SectionSerializer.new(step.sections).serializable_hash[:data].map { |d| d[:attributes][:en] }
    }
  end

  attribute :ar do |step|
    {
      title: step.title_ar,
      sections: SectionSerializer.new(step.sections).serializable_hash[:data].map { |d| d[:attributes][:ar] }
    }
  end
end
