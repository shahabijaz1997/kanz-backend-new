module V1
  class NotificationsController < ApiController
    def index
      notifications = current_user.notifications.pending_read
      success(
        'success',
        NotificationSerializer.new(notifications).serializable_hash[:data].map{|d| d[:attributes]}
      )
    end
  end
end
