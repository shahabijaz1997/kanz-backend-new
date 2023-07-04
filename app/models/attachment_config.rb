# frozen_string_literal: true

class AttachmentConfig < ApplicationRecord
  belongs_to :role
  has_many :attachments

  validates_presence_of :name
  validates :name, uniqueness: { scope: [:role_id] }
end
