# frozen_string_literal: true

class AdminRole < ApplicationRecord
  has_many :admin_users

  enum title: ADMIN_ROLES

  validates :title, presence: true, uniqueness: true

  scope :admins, -> { where(title: ['Super Admin', 'Admin']) }
  scope :representatives, -> { where(title: ['Customer Support Rep', 'Compliance Officer']) }
end
