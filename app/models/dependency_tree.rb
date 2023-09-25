# frozen_string_literal: true

# Dependency Tree
class DependencyTree < ApplicationRecord
  enum condition: { equals: 0 }
  enum operation: { show: 0, hide: 1 }

  belongs_to :dependable_field, class_name: 'FieldAttribute', polymorphic: true
  belongs_to :dependent_field, class_name: 'FieldAttribute', polymorphic: true
  belongs_to :section, polymorphic: true
  belongs_to :step, class_name: 'Stepper', polymorphic: true
end