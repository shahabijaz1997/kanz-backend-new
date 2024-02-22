# frozen_string_literal: true

module Notifications
  class Base < ApplicationService
    attr_reader :activity

    def initialize(activity)
      super()
      @activity = activity
    end

    def call
      notification_message = MessageBuilder.call(activity) # need to set kind and message_ar

      recipients.each do |recipient|
        Notification.create(message: notification_message,
                            message_ar: notification_message,
                            recipient_id: recipient.id,
                            activity_id: activity.id,
                            kind: activity.action)
      end
    end

    private

    def recipients
      return activity.record.investors if deal_activity?
      return deal_recipients if deal_added?
      return [activity.record.recipients] if invited?
    end

    def deal_activity?
      activity.action.in? %w[rental_amount_changed rental_cycle_changed deal_update_published deal_valuation_changed]
    end

    def deal_added?
      activity.action.eql?('new_deal')
    end

    def invited?
      activity.action.in? %w[syndicate_membership syndicate_membership_invite syndicate_membership_request
                             syndication_invite syndication_request syndicate_assigned investment_invite]
    end

    def deal_recipients
      activity.record.classic? ? Investor.approved.active : Syndicate.approved
    end
  end
end
