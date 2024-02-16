class Notification < ApplicationRecord
  enum status: %i[pending_read read]
  enum kind: %i[deal_invite syndicat_group_update investment_update deal_invitation deal_update]

  belongs_to :activity
  belongs_to :recipient, class_name: 'User'

  validates :message, :message_ar, presence: true

  scope :latest_first, -> { order(created_at: :desc) }

  def localized_message
    I18n.locale == :en ? message : message_ar
  end
end
