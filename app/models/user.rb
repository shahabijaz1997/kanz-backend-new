# frozen_string_literal: true

# User Modal
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  enum role: {
    'Individual Investor': 0,
    'Investment Firm': 1,
    'Startup': 2,
    'Syndicate': 3,
    'Property': 4
  }

  # Include default devise modules
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :investment_philosophies
  has_many :questions, through: :investment_philosophies

  PASSWORD_REQUIREMENTS = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x

  has_many :attachments, as: :parent, dependent: :destroy

  validates :password, format: PASSWORD_REQUIREMENTS, if: :password_validation_needed?
  validates :role, inclusion: { in: roles.keys }

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
    individual_investor? || investment_firm?
  end

  private

  def password_validation_needed?
    new_record? || encrypted_password_changed?
  end
end
