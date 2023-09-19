# frozen_string_literal: true

class Deal < ApplicationRecord
  has_many :features, dependent: :destroy
  belongs_to :detail, polymorphic: true

  enum type: DEAL_TYPES

  def startup?
    deal_type == DEAL_TYPES[:startup]
  end

  def property?
    deal_type == DEAL_TYPES[:property]
  end
end
