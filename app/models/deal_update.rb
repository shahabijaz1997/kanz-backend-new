class DealUpdate < ApplicationRecord
  enum status: { pending: 0, published: 1 }

  belongs_to :deal
  belongs_to :added_by, class_name: 'User'
  belongs_to :published_by, class_name: 'AdminUser', optional: true
  has_one_attached :report

  validates :description, presence: true

  def report_url
    Rails.env.development? ? ActiveStorage::Blob.service.path_for(report.key) : report.url if report.attached?
  end
end
