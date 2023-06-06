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
  belongs_to :user_role, class_name: 'Role', foreign_key: :role_id

  delegate :title, to: :user_role, prefix: :role

  before_validation :update_role, on: :create

  # Devise override the confirmation token
  def generate_confirmation_token
    @raw_confirmation_token = SecureRandom.rand(100_000..999_999)

    self.confirmation_token = @raw_confirmation_token
    self.confirmation_sent_at = Time.now.utc
  end

  def individual_investor?
    role_title == 'Individual Investor'
  end

  def investment_firm?
    role_title == 'Investment Firm'
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
    title = investor? ? 'Individual Investor' : type
    self.role_id = Role.find_by(title: title).id
  end
end
