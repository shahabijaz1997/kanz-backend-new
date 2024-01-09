# frozen_string_literal: true

class SyndicateMember < ApplicationRecord
  belongs_to :syndicate_group
  belongs_to :member, class_name: 'User'
  belongs_to :role, optional: true

  validates :role_id, inclusion: { in: [Role.syndicate_lp.id, Role.syndicate_gp.id] }
  validates_uniqueness_of :member_id, scope: %i[syndicate_group_id]

  scope :by_syndicate, -> (syndicate_id) { joins(:syndicate_group).where(
                                           syndicate_group: { syndicate_id: syndicate_id }
                                          )}
  scope :lp, -> { where(role: Role.syndicate_lp) }
  scope :gp, -> { where(role: Role.syndicate_gp) }
  scope :latest_first, -> { order(created_at: :desc) }
  scope :filter_by_role, -> (title) { where(role_id: Role.where(title: title).pluck(:id))}

  def self.ransackable_attributes(auth_object = nil)
    %w[id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[member syndicate_group]
  end
end
