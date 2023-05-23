# frozen_string_literal: true

# User Modal
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: ROLES
  enum status: STATUSES

  validates :password, format: PASSWORD_REGEX, if: :password_validation_needed?
  validates :role, inclusion: { in: roles.keys, case_sensitive: false }
  validates :type, inclusion: { in: PERSONAS }

  before_save :update_status

  # Devise override the confirmation token
  def generate_confirmation_token
    @raw_confirmation_token = SecureRandom.rand(100_000..999_999)

    self.confirmation_token = @raw_confirmation_token
    self.confirmation_sent_at = Time.now.utc
  end

  def individual_investor?
    role == 'Individual Investor'
  end

  def investment_firm?
    role == 'Investment Firm'
  end

  def investor?
    type == 'Investor'
  end

  def syndicate?
    type == 'Syndicate'
  end

  private

  def password_validation_needed?
    new_record? || encrypted_password_changed?
  end

  def update_status
    if meta_info.present? && attachments.present?
      self.status = User::statuses[:submitted]
    elsif meta_info.present?
      self.status = User::statuses[:inprogress]
    end
  end
end
