# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :role_vise_attachments, dependent: :destroy
  validates_presence_of :title
  validates_uniqueness_of :title
end
