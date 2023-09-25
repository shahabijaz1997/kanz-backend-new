# frozen_string_literal: true

# Dependency Tree
class DependencyTree < ApplicationRecord
  enum condition: { equals: 0 }
  enum operation: { show: 0, hide: 1 }

  belongs_to :dependable, polymorphic: true
  belongs_to :dependent, polymorphic: true
end