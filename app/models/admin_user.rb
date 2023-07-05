class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  belongs_to :admin_role, class_name: 'AdminRole'
  
  validates :email, :first_name, :last_name, :admin_role_id, presence: true
  validates :email, uniqueness: true

  # before_validation :set_default_role 
  scope :customer_users, -> {where(admin_role_id: AdminRole.where(title: ["Customer Support Rep", "Compliance Officer"]).pluck(:id))}
  scope :all_role_users, -> {where.not(admin_role_id: nil )}


  def fullname
    "#{first_name} #{last_name}"
  end

  def admin?
    admin_role && admin_role.Admin?
  end   

  def super_admin?
    admin_role && admin_role.Super_Admin?
  end  

  def customer_support_rep?
    admin_role && admin_role.Customer_Support_Rep?
  end  

  def compliance_officer?
    admin_role && admin_role.Compliance_Officer?
  end  
   
  private

  def set_default_role
    self.admin_role ||= AdminRole.where(title: 'admin').first_or_create
  end

end
