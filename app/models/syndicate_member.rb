# frozen_string_literal: true

class SyndicateMember < ApplicationRecord
  belongs_to :syndicate

  enum connection: { added: 0, follower: 1 }

  scope :filter_by_connection, -> (connection) { where(connection: connection) }
end
