# frozen_string_literal: true

# User Modal
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :lockable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum status: STATUSES

  validates :type, inclusion: { in: PERSONAS }
  validate :password_strength, if: :password_validation_needed?
  validate :check_email_uniqueness

  has_many :attachments, as: :parent, dependent: :destroy
  belongs_to :user_role, class_name: 'Role', foreign_key: :role_id

  delegate :title, :title_ar, to: :user_role, prefix: :role

  before_validation :update_role, on: :create
  after_create :update_profile_state

  audited only: :status, on: %i[update]

  # Devise override the confirmation token
  def generate_confirmation_token
    return if provider.present?

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

  def arabic?
    language == 'ar'
  end

  def attempts_exceeded?
    failed_attempts >= self.class.maximum_attempts
  end

  def self.from_social_auth(auth)
    where(email: auth.email).first_or_create do |user|
      user.uid = auth.uid
      user.provider = auth.provider
      user.name = auth.name
      user.type = auth.type
      user.password = generate_password
      user.confirmed_at = Time.zone.now
      user.language = auth.language
    end
  end

  def serialized_data
    UserSerializer.new(self).serializable_hash[:data][:attributes]
  end

  def update_profile_state
    self.profile_states = {
      account_confirmed: self.confirmed?,
      profile_completed: false,
      questionnaire_steps_completed: 0,
      questionnaire_completed: false,
      attachments_completed: false
    }
    self.save
  end

  private

  def password_validation_needed?
    new_record? || encrypted_password_changed?
  end

  def update_role
    title = investor? ? 'Individual Investor' : type
    self.role_id = Role.find_by(title:).id
  end

  def generate_password(length = 12)
    chars = [('a'..'z'), ('A'..'Z'), (0..9),
             ['!', '@', '#', '$', '%', '^', '&', '*', '_', '-']].map(&:to_a).flatten
    password = SecureRandom.base64(length)
    password.gsub!(/[^a-zA-Z0-9!@#$%^&*_-]/, chars.sample)
    "#{password}!*^"
  end

  def password_strength
    unless PASSWORD_REGEX.match(password)
      errors.add(:base, I18n.t('errors.weak_password'))
    end
  end

  def check_email_uniqueness
    if new_record? && User.exists?(email: email)
      errors.add(:base, I18n.t('errors.email_taken'))
    end
  end
end
