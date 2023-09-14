# frozen_string_literal: true

class AttachmentConfig < ApplicationRecord
  belongs_to :role
  has_many :attachments, dependent: :nullify

  validates :name, presence: true
  validates :name, uniqueness: { scope: [:role_id] }
end
