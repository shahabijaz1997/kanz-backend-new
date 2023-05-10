# frozen_string_literal: true

class User < ApplicationRecord
  # will moved to config
  TOKEN_LIFE = 15.minutes

  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  PASSWORD_REQUIREMENTS= /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x
  validates :password, format: PASSWORD_REQUIREMENTS


  # Devise override the confirmation token
  def generate_confirmation_token
    @raw_confirmation_token = SecureRandom.rand(100000..999999)

    self.confirmation_token = @raw_confirmation_token
    self.confirmation_sent_at = Time.now.utc
  end

  def validate_confirmation_token(token)
    user = self.class.find_by(confirmation_token: token)
    return {status: false, message: 'Token not found'} if user.blank?
    return {status: false, message: 'Token expired!'} if token_expired?(user.confirmation_sent_at)

    {status: true, message: 'Valid token'}
  end

  def token_expired?(confirmation_sent_at)
    Time.now.utc - user.confirmation_sent_at.utc <= TOKEN_LIFE
  end
end
