# frozen_string_literal: true

class Syndicate < User
  has_one :profile, class_name: 'SyndicateProfile', dependent: :destroy
end
