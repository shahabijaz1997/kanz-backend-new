# frozen_string_literal: true

class Term < ApplicationRecord
  belongs_to :deal

  belongs_to :field_attribute

  scope :minimum_check_size, -> { where(field_attribute_id: FieldAttribute.minimum_check_size) }

  def value
    symbol = field_attribute.percent? ? '%' : field_attribute.sqft? ? 'sqft' : ''
    
    if custom_input.present?
      custom_input + symbol
    elsif enabled?
      'Enabled'
    end
  end
end
