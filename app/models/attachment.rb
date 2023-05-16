class Attachment < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_many_attached :files
end
