# frozen_string_literal: true

class Activity < ApplicationRecord
  validates :record_id, :record_type, :user_d, :user_type, :old_value, :new_value, presence: true

  belongs_to :record, polymorphic: true
  belongs_to :user, polymorphic: true
end
