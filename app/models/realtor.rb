# frozen_string_literal: true

class Realtor < User
  has_many :attachments, as: :parent, dependent: :destroy
end
