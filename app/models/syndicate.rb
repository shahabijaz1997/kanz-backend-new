# frozen_string_literal: true

class Syndicate < User
  has_one :profile, class_name: 'SyndicateProfile', dependent: :destroy
  has_many :deals
  has_one :syndicate_group

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name status]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['profile']
  end

  def syndicate_members
    syndicate_group.syndicate_members
  end

  def membership(member_id)
    syndicate_members.find_by(member_id: member_id)
  end
end
