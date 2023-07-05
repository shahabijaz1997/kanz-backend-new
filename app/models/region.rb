# frozen_string_literal: true

class Region < ApplicationRecord
  validates :name, presence: true
end
