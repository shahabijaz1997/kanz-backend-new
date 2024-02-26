# frozen_string_literal: true

module DealState
  extend ActiveSupport::Concern

  included do
    validates(:target, numericality: { greater_than_or_equal_to: 1, less_than: BIGINT_LIMIT, allow_nil: true })
    validate :start_date_and_end_date
    before_update :validate_status_change

    def start_date_in_future
      return if start_at.blank? || start_at > Time.zone.now

      errors.add(:base, I18n.t('deal.start_date_in_future'))
    end

    def start_date_and_end_date
      errors.add(:base, I18n.t('deal.dates_presence')) unless draft? && (start_at.blank? || end_at.blank?)
      errors.add(:base, I18n.t('deal.end_date_after_start')) if errors.blank? && start_at > end_at
    end

    def validate_status_change
      errors.add(:base, I18n.t('deal.submitted_condition')) if submitted? && %w[draft reopened].exclude?(status_was)
      errors.add(:base, I18n.t('deal.verified_condition')) if verified? && status_was != 'submitted'
      errors.add(:base, I18n.t('deal.reopened_condition')) if reopened? && %w[verified submitted].exclude?(status_was)
      validate_approved_and_live
    end

    def validate_approved_and_live
      errors.add(:base, I18n.t('deal.approved_condition')) if approved? && status_was != 'verified'
      errors.add(:base, I18n.t('deal.live_condition')) if live? && status_was != 'approved'
    end
  end
end
