# frozen_string_literal: true

class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  enum role: {
    'Individual Invester': 'investor',
    'Investment Firm': 'firm investor',
    'Startup': 'startup',
    'Syndicate': 'syndicate',
    'Property': 'property'
  }

  # Include default devise modules
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  PASSWORD_REQUIREMENTS= /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x

  validates :password, format: PASSWORD_REQUIREMENTS, if: :password_validation_needed?
  validates :role, inclusion: { in: roles.keys }

  # Devise override the confirmation token
  def generate_confirmation_token
    @raw_confirmation_token = SecureRandom.rand(100000..999999)

    self.confirmation_token = @raw_confirmation_token
    self.confirmation_sent_at = Time.now.utc
  end

  private

  def password_validation_needed?
    new_record? || encrypted_password_changed?
  end
end
