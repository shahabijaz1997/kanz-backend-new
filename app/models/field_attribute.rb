# frozen_string_literal: true

class FieldAttribute < ApplicationRecord
  enum field_type: FIELD_TYPE
  enum input_type: INPUT_TYPES
  has_many :options, as: :optionable, class_name: 'Option', dependent: :destroy
  belongs_to :section
  has_many :dependencies, as: :dependable, class_name: 'DependencyTree', dependent: :destroy
  has_many :dependents, as: :dependent, class_name: 'DependencyTree', dependent: :destroy
  has_many :attachment, as: :configurable, dependent: :destroy
  has_many :terms, dependent: :destroy

  accepts_nested_attributes_for :options

  def dependent_field
    self.class.find_by(id: dependent_id)
  end

  class << self
    def minimum_check_size
      where(field_mapping: 'terms_attributes.custom_input', statement: 'Minimum Check Size').pluck(:id)
    end

    def investment_round
      find_by(field_mapping: 'funding_round_attributes.round_id')
    end

    def self.ransackable_attributes(_auth_object = nil)
      %w[statement lable field_type input_type]
    end

    def self.ransackable_associations(_auth_object = nil)
      %w[options section]
    end
  end
end
