# frozen_string_literal: true

class Deal < ApplicationRecord
  attr_accessor :step

  belongs_to :user, foreign_key: 'author_id'
  has_many :features, dependent: :destroy
  has_many :terms, dependent: :destroy
  has_one :funding_round
  has_one :property_detail
  has_many :attachments, as: :parent, dependent: :destroy
  has_many :external_links, dependent: :destroy

  accepts_nested_attributes_for :features
  accepts_nested_attributes_for :terms
  accepts_nested_attributes_for :funding_round
  accepts_nested_attributes_for :property_detail
  accepts_nested_attributes_for :external_links

  enum deal_type: DEAL_TYPES
  enum status: { draft: 0, submitted: 1 }

  after_save :update_current_state

  def update_current_state
    current_state['current_step'] = step
    current_state['submitted'] = submitted?
    current_state['steps'] ||= []
    current_state['steps'] = current_state['steps'] | [step].compact

    self.update_column(:current_state, current_state)
  end
end
