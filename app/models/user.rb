# frozen_string_literal: true

# User Modal
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include UserOnboarding

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :lockable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum status: STATUSES

  validates :type, inclusion: { in: PERSONAS }
  validate :password_strength, if: :password_validation_needed?
  validate :check_email_uniqueness

  has_one :wallet

  has_many :attachments, as: :parent, dependent: :destroy
  has_many :deals, dependent: :destroy
  belongs_to :user_role, class_name: 'Role', foreign_key: :role_id
  has_many :invites, dependent: :destroy
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id'
  has_many :deal_updates, foreign_key: 'added_by_id'
  has_many :investments, dependent: :destroy
  has_one_attached :profile_picture
  has_many :activities, as: :user

  delegate :title, :title_ar, to: :user_role, prefix: :role

  before_validation :update_role, on: :create
  after_create :update_profile_state, :create_wallet
  after_save :update_profile_state, if: :profile_reopened?
  after_update :inform_applicant, if: :saved_change_to_status?

  scope :approved, -> { where(status: User::statuses[:approved]) }

  audited only: :status, on: %i[update]

  # Devise override the confirmation token
  def generate_confirmation_token
    return if provider.present?

    @raw_confirmation_token = SecureRandom.rand(100_000..999_999)

    self.confirmation_token = @raw_confirmation_token
    self.confirmation_sent_at = Time.now.utc
  end

  def investor?
    type == 'Investor'
  end

  def syndicate?
    type == 'Syndicate'
  end

  def fund_raiser?
    type == 'FundRaiser'
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
    investor_type = profile_reopened? && investor? ? user_role&.title : ''
    self.profile_states = {
      investor_type: investor_type || '',
      account_confirmed: confirmed?,
      profile_current_step: 1,
      profile_completed: false,
      questionnaire_steps_completed: 0,
      questionnaire_completed: false,
      attachments_completed: false
    }
    save
  end

  def investments_in_deal(deal_id)
    investments.where(deal_id: deal_id).pluck(:amount).reduce(:+)
  end

  def no_investments
    investments.count
  end

  def invested_amount
    investments.sum(:amount)
  end

  def total_deals
    deals.count
  end

  def no_active_deals
    deals.live.count
  end

  def profile_picture_url
    Rails.env.development? ? ActiveStorage::Blob.service.path_for(profile_picture.key) : profile_picture.url if profile_picture.attached?
  end

  private

  def create_wallet
    Wallet.create(user: self, balance: 0.0)
  end

  def profile_reopened?
    saved_change_to_status && saved_change_to_status.last == 'reopened'
  end

  def password_validation_needed?
    new_record? || encrypted_password_changed?
  end

  def update_role
    title = investor? ? 'Individual Investor' : type
    title = title == 'FundRaiser' ? 'Fund Raiser' : title
    self.role_id = Role.find_by(title:).id
  end

  def self.generate_password(length = 12)
    chars = [('a'..'z'), ('A'..'Z'), (0..9),
             ['!', '@', '#', '$', '%', '^', '&', '*', '_', '-']].map(&:to_a).flatten
    password = SecureRandom.base64(length)
    password.gsub!(/[^a-zA-Z0-9!@#$%^&*_-]/, chars.sample)
    "#{password}!*^"
  end

  def password_strength
    return if PASSWORD_REGEX.match(password)

    errors.add(:base, I18n.t('errors.weak_password'))
  end

  def check_email_uniqueness
    return unless new_record? && User.exists?(email:)

    errors.add(:base, I18n.t('errors.email_taken'))
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[profile]
  end
end
