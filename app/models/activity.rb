# frozen_string_literal: true

class Activity < ApplicationRecord

  enum actions: %i[added invited modified removed]
  validates :record_id, :record_type, :user_id, :user_type, :old_value, :new_value, presence: true

  belongs_to :record, polymorphic: true
  belongs_to :user, polymorphic: true

  after_create :add_notifications

  private

  def add_notifications
    Notifications::Base.call(self)
  end
end
