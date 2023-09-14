# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :attachment_configs, dependent: :destroy
  validates :title, presence: true
  validates :title, uniqueness: true
end
