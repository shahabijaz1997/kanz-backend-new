class DealUpdate < ApplicationRecord
  enum status: { pending: 0, published: 1 }

  belongs_to :deal
  belongs_to :added_by, class_name: 'User'
  belongs_to :published_by, class_name: 'AdminUser', optional: true
  has_one_attached :report

  validates :description, presence: true
  validate :deal_updatable

  before_validation :set_directory_path

  def report_url
    Rails.env.development? ? local_storage_path : report.url(expires_in: 30.minutes)
  end

  def report_path
    report.url
  end

  private

  def deal_updatable
    return errors.add(:deal, I18n.t('deal_update.deal_not_closed')) unless deal.closed?
    return errors.add(:user, I18n.t('deal_update.not_allowed')) if deal.syndicate? && added_by_id != deal.syndicate_id
    return errors.add(:user, I18n.t('deal_update.not_allowed')) if deal.classic? && added_by_id != deal.user_id
  end

  def set_directory_path
    gust = SecureRandom.base36(28)
    report.key = "deal_update/#{deal_id}/#{gust}" if report.new_record?
  end

  def local_storage_path
    return '' if report.blank?

    ActiveStorage::Blob.service.path_for(report.key)
  rescue StandardError => error
    ''
  end
end
