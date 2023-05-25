# frozen_string_literal: true

class Startup < User
  has_many :attachments, as: :parent, dependent: :destroy
end
