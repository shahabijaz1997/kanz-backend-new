# frozen_string_literal: true

class AttachmentConfig < ApplicationRecord
  belongs_to :role
  has_many :attachments, as: :configurable, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: { scope: [:role_id] }
end
