# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :parent, polymorphic: true
  belongs_to :attachment_config, optional: true

  has_one_attached :file

  before_validation :set_directory_path
  after_save :update_user_status

  def url
    Rails.env.development? ? local_storage_path : file.url
  end

  def self.upload_file(attachable, file, name = 'logo')
    attachment = Attachment.find_or_initialize_by(name: name, parent: attachable)
    attachment.file.attach(file)
    attachment.save!
  end

  private

  def update_user_status
    return unless parent_type == 'User'

    UserState::Manager.call(parent)
  end

  def set_directory_path
    gust = SecureRandom.base36(28)
    file.key = "#{parent.try(:type) || parent_type}/#{parent&.id}/#{gust}" if file.new_record?
  end

  def local_storage_path
    ActiveStorage::Blob.service.path_for(file.key)
  end
end
