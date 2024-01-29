# frozen_string_literal: true

class Term < ApplicationRecord
  belongs_to :deal

  belongs_to :field_attribute

  scope :minimum_check_size, -> { where(field_attribute_id: FieldAttribute.minimum_check_size) }

  def statement
    field_attribute.localized_statement
  end

  def value
    return "#{custom_input}#{input_symbol}" if custom_input.present?

    enabled? ? 'Yes' : 'No'
  end

  private

  def input_symbol
    return '%' if field_attribute.percent?
    return I18n.t('sqft') if field_attribute.sqft?
    return '$' if field_attribute.currency?
    ''
  end
end
