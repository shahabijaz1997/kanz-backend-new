# frozen_string_literal: true

class Syndicate < User
  has_one :profile, class_name: 'SyndicateProfile', dependent: :destroy
  has_many :deals
  has_many :syndicate_members

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['profile']
  end

  def total_deals
    deals.count
  end

  def no_active_deals
    deals.live.count
  end

  def membership(member_id)
    syndicate_members.find_by(member_id: member_id)
  end
end
