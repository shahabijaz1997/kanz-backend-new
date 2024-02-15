# frozen_string_literal: true

class Deal < ApplicationRecord
  attr_accessor :step

  belongs_to :user
  has_many :features, dependent: :destroy
  has_many :terms, dependent: :destroy
  has_one :funding_round
  has_one :property_detail
  has_many :attachments, as: :parent, dependent: :destroy
  has_many :external_links, dependent: :destroy
  has_many :invites, as: :eventable, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :syndicate, class_name: 'Syndicate', optional: true
  has_many :deal_updates
  has_one :spv
  has_many :investments, dependent: :destroy
  has_many :investors, through: :investments, source: 'user'
  has_many :activities, as: :record

  accepts_nested_attributes_for :features, :external_links, allow_destroy: true
  accepts_nested_attributes_for :terms
  accepts_nested_attributes_for :funding_round
  accepts_nested_attributes_for :property_detail

  enum deal_type: DEAL_TYPES
  enum status: { draft: 0, submitted: 1, reopened: 2, verified: 3, rejected: 4, approved: 5, live: 6, closed: 7 }
  enum model: { _: 0, classic: 1, syndicate: 2 }
  enum closing_model: { fifs: 0, adjust_pro_rata: 1, refunded_and_closed: 2 }

  validates_numericality_of(:target, greater_than_or_equal_to: 1, less_than: BIGINT_LIMIT, allow_nil: true)
  validate :start_and_end_date_presence, :start_date_and_end_date

  after_save :update_current_state
  before_update :validate_status_change
  after_update :notify_deal_approval

  audited only: %i[status target], on: %i[update]

  scope :approved, -> { where(status: Deal::statuses[:approved]) }
  scope :live, -> { where(status: Deal::statuses[:live]) }
  scope :approved_or_live, -> { where(status: [Deal::statuses[:approved], Deal::statuses[:live]]) }
  scope :syndicate_model, -> { where(model: Deal::models[:syndicate]) }
  scope :classic_model, -> { where(model: Deal::models[:classic]) }
  scope :syndicate_deals, ->(id) { approved_or_live.syndicate_model.or(Deal.live_or_closed.classic_model).or(Deal.closed.where(syndicate_id: id)) }
  scope :latest_first, -> { order(created_at: :desc) }
  scope :by_status, -> (status) { where(status: status) }
  scope :by_type, -> (type) { where(deal_type: type) }
  scope :live_or_closed, -> { where(status: [Deal::statuses[:closed], Deal::statuses[:live]]) }
  scope :user_invested, -> (user_id) { joins(:investments).where(investments: {user_id: user_id}) }
  scope :equity, -> { joins(:funding_round).where.not(funding_round: { equity_type_id: nil, round_id: nil }) }
  scope :rental, -> { joins(:property_detail).where( property_detail: { is_rental: true })}
  scope :non_rental, -> { joins(:property_detail).where( property_detail: { is_rental: [false, nil] })}
  scope :approved_live_or_closed, -> { where(status: [Deal::statuses[:approved], Deal::statuses[:closed], Deal::statuses[:live]]) }

  def attachments_by_creator
    attachments.where(uploaded_by: user)
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[title status target]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user property_detail funding_round syndicate]
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
    investments.sum(:amount)
  end

  def investors_count
    investments.pluck(:user_id).uniq.count
  end

  def minimum_check_size
    terms.minimum_check_size.first&.custom_input.to_f
  end

  def activities
    invites.where.not(invitee_id: investments.pluck(:user_id)).latest_first + investments.latest_first
  end

  def investment_round
    funding_round&.stage
  end

  def current_valuation
    target.to_f
  end

  def previous_valuation
    target.to_f
  end

  def waiting_closure?
    live? && end_at <= Date.today
  end

  def investment_multiple
    current_valuation / previous_valuation
  end

  def rental_duration
    property_detail&.rental_duration
  end

  def valuation_phase
    funding_round&.valuation_type
  end

  private

  def start_date_in_future
    return if start_at.blank?
    return if start_at > Time.zone.now
    errors.add(:base, I18n.t('deal.start_date_in_future'))
  end

  def start_date_and_end_date
    return if start_at.blank? || end_at.blank?
    return if start_at < end_at
    errors.add(:base, I18n.t('deal.end_date_after_start'))
  end

  def start_and_end_date_presence
    return if draft?
    return if start_at.present? && end_at.present?
    errors.add(:base, I18n.t('deal.dates_presence'))
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
      errors[:base] << I18n.t('deal.submitted_condition')
    elsif status == 'verified' && status_was != 'submitted'
      errors[:base] << I18n.t('deal.verified_condition')
    elsif status == 'reopened' && !(status_was.in? %w[verified submitted])
      errors[:base] << I18n.t('deal.reopened_condition')
    elsif status == 'approved' && status_was != 'verified'
      errors[:base] << I18n.t('deal.approved_condition')
    elsif status == 'live' && status_was != 'approved'
      errors[:base] << I18n.t('deal.live_condition')
    end
  end

  def notify_deal_approval
    return if status != 'live'

    DealsMailer.deal_signed_of(self).deliver_now
  end
end
