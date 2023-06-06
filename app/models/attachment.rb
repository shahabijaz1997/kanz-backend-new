# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :parent, polymorphic: true

  has_one_attached :file

  before_validation :set_directory_path
  after_save :update_user_status

  private

  def update_user_status
    UserState::Manager.call(parent)
  end

  def set_directory_path
    gust = SecureRandom.base36(28)
    file.key = "#{parent.type}/#{parent.id}/#{gust}" if file.new_record?
  end
end
