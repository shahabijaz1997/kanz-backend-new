# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  belongs_to :deal
  belongs_to :country
end
