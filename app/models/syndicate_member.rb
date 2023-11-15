# frozen_string_literal: true

class SyndicateMember < ApplicationRecord
  belongs_to :syndicate
  belongs_to :member, polymorphic: true

  enum connection: { added: 0, follower: 1 }
end
