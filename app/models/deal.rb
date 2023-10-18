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

  accepts_nested_attributes_for :features, :external_links, allow_destroy: true
  accepts_nested_attributes_for :terms
  accepts_nested_attributes_for :funding_round
  accepts_nested_attributes_for :property_detail

  enum deal_type: DEAL_TYPES
  enum status: { draft: 0, submitted: 1, reopened: 2, verified: 3, rejected: 4, approved: 5 }
  enum model: { classic: 0, syndicate: 1 }

  after_save :update_current_state

  audited only: :status, on: %i[update]

  def update_current_state
    current_state['current_step'] = step
    current_state['submitted'] = submitted?
    current_state['steps'] ||= []
    current_state['steps'] = (current_state['steps'] | [step].compact)

    self.update_column(:current_state, current_state)
  end

  def attachments_by_creator
    attachments.where(uploaded_by: nil)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title status target]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user property_detail funding_round]
  end
end
