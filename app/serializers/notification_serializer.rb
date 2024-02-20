# frozen_string_literal: true

# Deal json serializer
class NotificationSerializer
  include JSONAPI::Serializer
  # added invited modified removed
  attributes :id

  attribute :profile_pic do |notification|
    activity = notification.activity
    activity.user_type == 'AdminUser' ? nil : activity.user.profile_picture_url
  end

  attribute :user_name do |notification|
    activity = notification.activity
    activity.user_type == 'AdminUser' ? 'Back Office' : activity.user.name
  end

  attribute :message do |notification|
    notification.localized_message
  end

  attribute :created_at do |notification|
    DateTime.parse(notification.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end

  attribute :type do |notification|
    notification.kind # Need to be humanize
  end

  attribute :has_details do |notification|
    notification.deal_update_published?
  end

  attribute :detail_id do |notification|
    notification.deal_update_published? ? notification.activity.record_id : nil
  end
end
