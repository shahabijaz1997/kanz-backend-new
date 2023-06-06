# frozen_string_literal: true

# User Modal
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable, :trackable, :lockable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum status: STATUSES

  validates :password, format: PASSWORD_REGEX, if: :password_validation_needed?
  validates :type, inclusion: { in: PERSONAS }

  has_many :attachments, as: :parent, dependent: :destroy
  belongs_to :role

  before_validation :update_role

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

  def startup?
    type == 'Startup'
  end

  def realtor?
    type == 'Realtor'
  end

  def attempts_exceeded?
    self.failed_attempts >= self.class.maximum_attempts
  end

  private

  def password_validation_needed?
    new_record? || encrypted_password_changed?
  end

  def update_role
    self.role = Role.find_by(title: type)
  end
end
