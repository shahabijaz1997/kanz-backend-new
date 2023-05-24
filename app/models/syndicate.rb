# frozen_string_literal: true

class Syndicate < User
  has_many :attachments, as: :parent, dependent: :destroy
  has_one :syndicate_profile, dependent: :destroy
end
