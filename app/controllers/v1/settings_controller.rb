# frozen_string_literal: true

# Startups apis
module V1
  class SettingsController < ApplicationController
    def attachments
      attachment_configs = current_user.user_role.attachment_configs.map do |config|
        attachment = Attachment.find_by(attachment_config_id: config.id, parent: current_user)

        AttachmentConfigSerializer.new(
          config).serializable_hash[:data][:attributes].merge(
          attachment_url: attachment&.url)
      end

      success(I18n.t('realtor.get.success.show'), attachment_configs)
    end
  end
end
