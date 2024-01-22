# frozen_string_literal: true

class Syndicate < User
  has_one :profile, class_name: 'SyndicateProfile', dependent: :destroy
  has_many :deals
  has_one :syndicate_group

  scope :applied, -> (user_id) { joins(syndicate_group: :invites).where(invites: {status: Invite::statuses[:pending], user_id: user_id }).distinct }
  scope :invite_received, -> (user_id) { joins(syndicate_group: :invites).where(invites: {status: Invite::statuses[:pending], invitee_id: user_id }).distinct }
  scope :not_invited, -> (user_id) {
                                      where.not(id: (joins(syndicate_group: :invites).
                                      where("invites.status = ? and invites.invitee_id = ? or invites.user_id =?",
                                      Invite::statuses[:pending], user_id, user_id).pluck(:id)))
                                   }
  scope :has_active_deal, -> { joins(:deals).where.not(deals: { id: nil }).where(deals: { status: Deal::statuses[:live] }).distinct }
  scope :no_active_deal, -> { where.not(id: has_active_deal.pluck(:id)).distinct }

  accepts_nested_attributes_for :profile, update_only: true

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
