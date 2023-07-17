# frozen_string_literal: true

class Region < ApplicationRecord
  validates :name, presence: true
  has_many :profiles_regions, dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[id]
  end
end
