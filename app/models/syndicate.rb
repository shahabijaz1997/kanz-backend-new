# frozen_string_literal: true

class Syndicate < User
  has_many :attachments, as: :parent, dependent: :destroy
  has_one :profile, class_name: 'SyndicateProfile'
end
