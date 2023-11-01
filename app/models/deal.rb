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
  has_many :invites, as: :eventable, dependent: :destroy
  has_many :comments

  accepts_nested_attributes_for :features, :external_links, allow_destroy: true
  accepts_nested_attributes_for :terms
  accepts_nested_attributes_for :funding_round
  accepts_nested_attributes_for :property_detail

  enum deal_type: DEAL_TYPES
  enum status: { draft: 0, submitted: 1, reopened: 2, verified: 3, rejected: 4, approved: 5 }
  enum model: { classic: 0, syndicate: 1 }

  after_save :update_current_state
  before_update :validate_status_change

  audited only: :status, on: %i[update]

  scope :approved, -> { where(status: Deal::statuses[:approved]) }
  scope :syndicate_model, -> { where(model: Deal::models[:syndicate]) }
  scope :syndicate_deals, -> { approved.syndicate_model }
  scope :latest_first, -> { order(created_at: :desc) }

  def update_current_state
    current_state['current_step'] = submitted? ? 0 : step
    current_state['submitted'] = submitted?
    current_state['steps'] ||= []
    current_state['steps'] = [] if submitted?
    current_state['steps'] = (current_state['steps'] | [step].compact)

    self.update_column(:current_state, current_state)
  end

  def attachments_by_creator
    attachments.where(uploaded_by: user)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title status target]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user property_detail funding_round]
  end

  def validate_status_change
    if status == 'submitted' && !(status_was.in? %w[draft reopened])
      errors[:base] << 'Only draft or reopened deals can be submitted'
    elsif status == 'verified' && status_was != 'submitted'
      errors[:base] << 'Only submitted deals can be verified'
    elsif status == 'reopened' && !(status_was.in? %w[verified submitted])
      errors[:base] << 'Only submitted or verified deals can be reopened'
    elsif status == 'approved' && status_was != 'verified'
      errors[:base] << 'Only verified deals can be approved'
    end
  end

  def syndicate_comment(author_id)
    comments.find_by(author_id: author_id, thread_id: nil)
  end

  def syndicate_docs(syndicate_id)
    return [] if Syndicate.exists?(id: syndicate_id)

    attachments.where(uploaded_by: syndicate_id)
  end
end
