# frozen_string_literal: true

class Deal < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :features, dependent: :destroy
  has_many :terms, dependent: :destroy
  has_one :funding_round
  has_one :property_detail
  has_one :attachment, as: :parent, dependent: :destroy

  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :terms
  accepts_nested_attributes_for :funding_round
  accepts_nested_attributes_for :property_detail

  enum deal_type: DEAL_TYPES
end
