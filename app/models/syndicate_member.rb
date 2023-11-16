# frozen_string_literal: true

class SyndicateMember < ApplicationRecord
  belongs_to :syndicate
  belongs_to :member, class_name: 'User'

  enum connection: { added: 0, follower: 1 }

  scope :filter_by_connection, -> (connection) { where(connection: connection) }
end
