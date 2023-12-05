# frozen_string_literal: true

class SyndicateMember < ApplicationRecord
  belongs_to :syndicate
  belongs_to :member, class_name: 'User'

  enum connection: { added: 0, follower: 1 }

  scope :filter_by_connection, -> (connection) { where(connection: connection) }
  scope :by_syndicate, -> (syndicate_id) {where(syndicate_id: syndicate_id)}
  scope :latest_first, -> { order(created_at: :desc) }

  def self.ransackable_associations(_auth_object = nil)
    %w[member]
  end
end
