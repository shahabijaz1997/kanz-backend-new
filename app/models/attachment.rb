# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_one_attached :file

  after_save :update_user_status

  private

  def update_user_status
    UserState::Manager.call(parent)
  end
end
