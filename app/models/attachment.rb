# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_one_attached :file
end
