# frozen_string_literal: true

class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :admin_role, class_name: 'AdminRole'
  has_many :deal_updates, foreign_key: 'published_by_id'
  has_many :spvs, foreign_key: :created_by
  has_many :attachments, as: :parent, dependent: :destroy

  validates :email, :first_name, :last_name, presence: true
  validates :email, uniqueness: true

  scope :customer_users, lambda {
                           where(admin_role_id: AdminRole.where(title: ['Customer Support Rep', 'Compliance Officer']).select(:id))
                         }
  scope :customer_support_rep, -> { where(admin_role_id: AdminRole.find_by(title: 'Customer Support Rep')) }
  scope :compliance_officer, -> { where(admin_role_id: AdminRole.find_by(title: 'Compliance Officer')) }
  scope :all_role_users, -> { where.not(admin_role_id: nil) }

  def fullname
    "#{first_name} #{last_name}"
  end

  def admin?
    admin_role&.Admin?
  end

  def super_admin?
    admin_role&.Super_Admin?
  end

  def customer_support_rep?
    admin_role&.Customer_Support_Rep?
  end

  def compliance_officer?
    admin_role&.Compliance_Officer?
  end

  def content_manager?
    admin_role&.Content_Manager?
  end

  def content_creator?
    admin_role&.Content_Creator?
  end

  def role
    if admin? || super_admin?
      :admin
    elsif content_manager? || content_creator?
      :content_manager
    else
      :customer_user
    end
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[id email first_name last_name admin_role_id created_at]
  end

  def destroy
    update(deactivated: true) unless deactivated
  end

  def reactivate
    update(deactivated: false) if deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end

  def inactive_message
    deactivated ? :is_deactivated : super
  end

  private

  def set_default_role
    self.admin_role ||= AdminRole.where(title: 'admin').first_or_create
  end
end
