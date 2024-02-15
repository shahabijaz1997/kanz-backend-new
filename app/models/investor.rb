# frozen_string_literal: true

class Investor < User
  has_many :investment_philosophies, class_name: 'UsersResponse', foreign_key: :user_id, dependent: :destroy,
                                     inverse_of: :user
  has_many :questions, through: :users_responses
  has_one :profile, class_name: 'InvestorProfile', dependent: :destroy
  has_many :syndicate_members, class_name: 'SyndicateMember', foreign_key: :member_id, dependent: :destroy

  scope :individuals, -> { where(user_role: Role.individual_investor) }
  scope :firms, -> { where(user_role: Role.firm_investor) }
  scope :filter_by_role, -> (title) { where(role_id: Role.where(title: title).pluck(:id))}

  def individual_investor?
    role_title == INDIVIDUAL_INVESTOR
  end

  def investment_firm?
    role_title == INVESTMENT_FIRM
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

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['profile']
  end

  def following?(syndicate_id)
    syndicate_members.exists?(syndicate_id: syndicate_id)
  end

  def profile_pic
    profile_picture_url
  end
end
