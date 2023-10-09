# frozen_string_literal: true

# Questions Modal
class Stepper < ApplicationRecord
  enum stepper_type: STEPPERS

  has_many :sections, dependent: :destroy
  has_many :dependents, as: :dependent, class_name: 'DependencyTree', dependent: :destroy

  validates :index, presence: true
  validates :title, presence: true, uniqueness: { scope: :stepper_type }

  accepts_nested_attributes_for :sections

  scope :startup_deal_steps, -> { where(stepper_type: STEPPERS[:startup_deal]) }
  scope :property_deal_steps, -> { where(stepper_type: STEPPERS[:property_deal]) }
end
