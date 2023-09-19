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

    def stepper
      steps = StepperSerializer.new(
                Stepper.where(stepper_type: STEPPERS[params[:type].to_sym])
              ).serializable_hash[:data].map { |d| d[:attributes] }
      success('Success', { step_titles: step_titles, steps: steps })
    end

    private

    def step_titles
      deal_steps = Stepper.where(stepper_type: STEPPERS[params[:type].to_sym]).order(:index)
      { 
        en: deal_steps.pluck(:title),
        ar: deal_steps.pluck(:title_ar)
      }
    end
  end
end
