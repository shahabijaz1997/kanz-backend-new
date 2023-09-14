# frozen_string_literal: true

class PropertyDetail < ApplicationRecord
  has_one :deal, as: :detail, dependent: :nullify
end
