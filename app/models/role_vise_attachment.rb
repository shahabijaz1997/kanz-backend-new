# frozen_string_literal: true

class RoleViseAttachment < ApplicationRecord
  belongs_to :role

  validates_presence_of :name
  validates :name, uniqueness: { scope: [:role_id] }
end
