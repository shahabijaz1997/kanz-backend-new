# frozen_string_literal: true

# Stepper's json serializer
class StepperReviewSerializer
  include JSONAPI::Serializer
  attributes :id, :index

  attribute :en do |step|
    fields = SectionSerializer.new(step.sections).serializable_hash[:data].map { |d| d[:attributes][:en][:fields] }
    fields = fields.map { |f| f[:statement] }
    
    {
      title: step.title,
      fields:
    }
  end

  attribute :ar do |step|
    {
      title: step.title_ar,
      sections: SectionSerializer.new(step.sections).serializable_hash[:data].map { |d| d[:attributes][:ar][:fields] }
    }
  end
end
