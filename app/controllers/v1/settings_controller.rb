# frozen_string_literal: true

# Startups apis
module V1
  class SettingsController < ApplicationController
    def attachments
      attachments = RoleViseAttachmentSerializer.new(
        current_user.role.role_vise_attachments
      ).serializable_hash[:data].map { |d| d[:attributes] }

      success(I18n.t('realtor.get.success.show'), attachments)
    end
  end
end
