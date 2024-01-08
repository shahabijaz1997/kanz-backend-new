# frozen_string_literal: true

class SyndicateGroup < ApplicationRecord
  belongs_to :syndicate
  has_many :invites, as: :eventable, dependent: :destroy
  has_many :syndicate_members, class_name: 'SyndicateMember', dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end
end
