# frozen_string_literal: true

class Attachment < ApplicationRecord
  belongs_to :parent, polymorphic: true
  belongs_to :configurable, polymorphic: true, optional: true
  belongs_to :uploaded_by, polymorphic: true, optional: true

  has_one_attached :file

  before_validation :set_directory_path

  def url
    Rails.env.development? ? local_storage_path : file.url(expires_in: 30.minutes)
  end

  def self.upload_file(attachable, file, name = 'logo')
    attachment = Attachment.find_or_initialize_by(name:, parent: attachable)
    attachment.file.attach(file)
    attachment.save!
  end

  private

  def set_directory_path
    gust = SecureRandom.base36(28)
    file.key = "#{parent.try(:type) || parent_type}/#{parent&.id}/#{gust}" if file.new_record?
  end

  def local_storage_path
    return '' if file.blank?

    ActiveStorage::Blob.service.path_for(file.key)
  end
end
