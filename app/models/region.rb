# frozen_string_literal: true

class Region < ApplicationRecord
  validates :name, presence: true
  has_many :profiles_regions, dependent: :destroy
end
