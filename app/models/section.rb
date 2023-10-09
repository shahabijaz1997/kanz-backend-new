# frozen_string_literal: true

# Questions Modal
class Section < ApplicationRecord
  belongs_to :stepper

  has_many :fields_sections, dependent: :destroy
  has_many :fields, through: :fields_sections, source: :field, dependent: :destroy

  has_many :dependents, as: :dependent, class_name: 'DependencyTree', dependent: :destroy

  validates :title, presence: true

  accepts_nested_attributes_for :fields
end
