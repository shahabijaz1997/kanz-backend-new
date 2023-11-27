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
  belongs_to :syndicate, class_name: 'Syndicate', optional: true
  has_many :investments

  accepts_nested_attributes_for :features, :external_links, allow_destroy: true
  accepts_nested_attributes_for :terms
  accepts_nested_attributes_for :funding_round
  accepts_nested_attributes_for :property_detail

  enum deal_type: DEAL_TYPES
  enum status: { draft: 0, submitted: 1, reopened: 2, verified: 3, rejected: 4, approved: 5, live: 6, closed: 7 }
  enum model: { classic: 0, syndicate: 1 }

  validate :start_and_end_date_presence, :start_date_and_end_date

  after_save :update_current_state
  before_update :validate_status_change
  after_update :notify_deal_approval

  audited only: :status, on: %i[update]

  scope :approved, -> { where(status: Deal::statuses[:approved]) }
  scope :live, -> { where(status: Deal::statuses[:live]) }
  scope :approved_or_live, -> { where(status: [Deal::statuses[:approved], Deal::statuses[:live]]) }
  scope :syndicate_model, -> { where(model: Deal::models[:syndicate]) }
  scope :syndicate_deals, -> { approved_or_live.syndicate_model }
  scope :latest_first, -> { order(created_at: :desc) }
  scope :by_status, -> (status) { where(status: status) }
  scope :by_type, -> (type) { where(deal_type: type) }
  scope :live_or_closed, -> { where(status: [Deal::statuses[:closed], Deal::statuses[:live]]) }
  scope :investor_deals, -> { live_or_closed.syndicate_model }

  def attachments_by_creator
    attachments.where(uploaded_by: user)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title status target]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user property_detail funding_round]
  end

  def syndicate_comment(author_id)
    comments.find_by(author_id: author_id, thread_id: nil)
  end

  def syndicate_and_creator_discussion(author_id)
    comments.where('author_id= ? OR recipient_id= ?', author_id, author_id).order(:created_at)
  end

  def syndicate_docs(syndicate_id)
    return [] unless Syndicate.exists?(id: syndicate_id)

    attachments.where(uploaded_by_id: syndicate_id)
  end

  def raised
    # implementation pending, if deal is live or closed then check for 
    0.00
  end

  def activities
    invites.investment
  end

  private

  def start_date_in_future
    return if start_at.blank?
    return if start_at > Time.zone.now
    errors.add(:base, 'Start date should be in future')
  end

  def start_date_and_end_date
    return if start_at.blank? || end_at.blank?
    return if start_at < end_at
    errors.add(:base, 'End date should be after start date')
  end

  def start_and_end_date_presence
    return if draft?
    return if start_at.present? && end_at.present?
    errors.add(:base, 'Start date and end date should be present')
  end

  def update_current_state
    current_state['current_step'] = submitted? ? 0 : step
    current_state['submitted'] = submitted?
    current_state['steps'] ||= []
    current_state['steps'] = [] if submitted?
    current_state['steps'] = (current_state['steps'] | [step].compact)

    self.update_column(:current_state, current_state)
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
    elsif status == 'live' && status_was != 'approved'
      errors[:base] << 'Only verified deals can be approved'
    end
  end

  def notify_deal_approval
    return if status != 'live'

    DealsMailer.deal_signed_of(self).deliver_now
  end
end
