module V1
  class NotificationsController < ApiController
    before_action :find_notification

    def index
      pagy notifications = pagy current_user.notifications.pending_read
      success(
        'success',
        {
          record: NotificationSerializer.new(notifications).serializable_hash[:data].map{|d| d[:attributes]},
          pagy: pagy
        }
      )
    end

    def update
      if @notification.update(update_params.merge(status: Notification.statuses[:read]))
        success('success')
      else
        failure(@notification.errors.full_messages.to_sentence)
      end
    end

    private

    def find_notification
      @notification = Notification.find_by(id: params[:id])
      failure(I18n.t('deal_update.not_found')) if @notification.blank?
    end

    def update_params
      params.require(:notification).permit(:id)
    end
  end
end
