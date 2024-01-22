# frozen_string_literal: true

class Option < ApplicationRecord
  belongs_to :optionable, polymorphic: true
  validates :statement, :index, presence: true
  validates :statement, uniqueness: { scope: [:optionable_id, :optionable_type] }

  def localized_statement
    I18n.locale == :en ? statement : statement_ar
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[statement]
  end
end
