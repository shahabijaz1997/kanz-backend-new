# frozen_string_literal: true

# Stepper's json serializer
class StepperSerializer
  include JSONAPI::Serializer
  attributes :id, :index

  attribute :dependencies do |step|
    dependencies = DependencyTree.where(
                     dependable_id: FieldAttribute.where(section_id: step.sections.pluck(:id)).pluck(:id),
                     dependable_type: 'FieldAttribute'
                   )
    DependencyTreeSerializer.new(dependencies).serializable_hash[:data].map { |d| d[:attributes] }
  end

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
