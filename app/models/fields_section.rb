# frozen_string_literal: true

# Join Table between Field and Section
class FieldsSection < ApplicationRecord
  belongs_to :section
  belongs_to :field, class_name: 'FieldAttribute'
end
