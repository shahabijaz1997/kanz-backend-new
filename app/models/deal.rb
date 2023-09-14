# frozen_string_literal: true

class Deal < ApplicationRecord
  has_many :unique_selling_points, dependent: :destroy, optional: true
  belongs_to :detail, polymorphic: true
end
