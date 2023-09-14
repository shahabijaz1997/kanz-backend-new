# frozen_string_literal: true

# Startups apis
module V1
  class SettingsController < ApiController
    def attachments
      attachment_configs = current_user.user_role.attachment_configs.map do |config|
        attachment = Attachment.find_by(attachment_config_id: config.id, parent: current_user)

        AttachmentConfigSerializer.new(
          config
        ).serializable_hash[:data][:attributes].merge({
          attachment_id: attachment&.id,
          attachment_url: attachment&.url,
          attachment_kind: attachment&.attachment_kind
        })
      end

      success(I18n.t('realtor.get.success.show'), attachment_configs)
    end

    def steps_schema
      resp = Settings::QuestionRetriever.call(params[:step], current_user, params[:type])
      resp.status ? success(resp.message, resp.data) : failure(resp.message, resp.code)
    end
  end
end
