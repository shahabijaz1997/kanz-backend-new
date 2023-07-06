# frozen_string_literal: true

class Syndicate < User
  has_one :profile, class_name: 'SyndicateProfile', dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["email", "name", "status"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["profile"]
  end
end
