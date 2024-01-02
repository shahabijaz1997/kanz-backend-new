# frozen_string_literal: true

class SyndicateMember < ApplicationRecord
  belongs_to :syndicate_group
  belongs_to :member, class_name: 'User'
  belongs_to :role

  before_create :set_default_role

  scope :by_syndicate, -> (syndicate_id) { joins(:syndicate_group).where(
                                           syndicate_group: { syndicate_id: syndicate_id }
                                          )}
  scope :lp, -> { where(role: Role.syndicate_lp) }
  scope :gp, -> { where(role: Role.syndicate_gp) }
  scope :latest_first, -> { order(created_at: :desc) }

  def self.ransackable_attributes(auth_object = nil)
    %w[id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[member syndicate_group]
  end

  private

  def set_default_role
    self.role = Role.syndicate_lp
  end
end
