# frozen_string_literal: true

class FieldAttribute < ApplicationRecord
  enum field_type: FIELD_TYPE
  has_many :options, as: :optionable, class_name: 'Option', dependent: :destroy
  has_many :fields_sections, dependent: :delete_all
  has_many :sections, through: :fields_sections
  has_many :dependencies, as: :dependable, class_name: 'DependencyTree', dependent: :destroy
  has_many :dependents, as: :dependent, class_name: 'DependencyTree', dependent: :destroy

  accepts_nested_attributes_for :options

  def dependent_field
    self.class.find_by(id: dependent_id)
  end
end
