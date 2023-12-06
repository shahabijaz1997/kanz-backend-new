# frozen_string_literal: true

# Settings api's
module V1
  class SettingsController < ApiController
    before_action :find_deal, :verify_deal_status, only: [:stepper]
    def attachments
      attachment_configs = current_user.user_role.attachment_configs.map do |config|
        attachment = Attachment.find_by(configurable_id: config.id, parent: current_user)

        AttachmentConfigSerializer.new(
          config
        ).serializable_hash[:data][:attributes].merge({
          attachment_id: attachment&.id,
          attachment_url: attachment&.url,
          attachment_kind: attachment&.attachment_kind
        })
      end

      success(I18n.t('fund_raiser.get.success.show'), attachment_configs)
    end

    def stepper
      @steppers = Stepper.where(stepper_type: STEPPERS[params[:type].to_sym]).order(:index)
      steps = Settings::ParamsMapper.call(@deal, @steppers)
      success('Success', steps)
    end

    private

    def find_deal
      @deal = current_user.deals.find_by(id: params[:id])
    end

    def verify_deal_status
      return true if @deal.blank?

     failure("Can't update #{@deal.status} deals") unless (@deal.draft? || @deal.reopened? || @deal.approved?)
    end
  end
end
