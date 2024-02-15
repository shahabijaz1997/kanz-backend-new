module Notifications
  class Base < ApplicationService
    attr_reader :activity
    def initialize(activity)
      @activity = activity
    end

    def call
      # need to set kind and message_ar
      recipients.each do |recipient|
        notification = Notification.new(message: message,
                                        message_ar: message,
                                        recipient_id: recipient.id,
                                        activity_id: activity.id)
        notification.save
      end
    end

    private

    def recipients
      return activity.record.investors if deal_modified?
      return (activity.record.classic? ? Investor.approved.active : Syndicate.approved) if deal_added?
      return [activity.record.recipient] if invited?
      return [activity.record] if removed?
    end

    def deal_modified?
      activity.record_type == 'Deal' && activity.action == Activity::actions[:modified]
    end

    def deal_added?
      activity.record_type == 'Deal' && activity.action == Activity::actions[:added]
    end

    def invited?
      activity.action == Activity::actions[:invited]
    end

    def invited?
      activity.action == Activity::actions[:removed]
    end

    def message
      case activity.action
      when Activity::actions[:added]
        added
      when Activity::actions[:removed]
        removed
      when Activity::actions[:invited]
        invited
      when Activity::actions[:modified]
        modified
      end
    end

    def added
      "#{activity.action} you in his #{activity.record_type.titlecase.downcase}"
    end

    def removed
      "#{activity.action} you from his #{activity.record_type.titlecase.downcase}"
    end

    def invited
      message = "to join his syndicate group" if activity.record.eventable_type == 'SyndicateGroup'
      message = "on his deal" if activity.record.eventable_type == 'Deal'
      "#{activity.action} you to #{message}"
    end

    def modified
      "modified #{activity.record_type.titlecase.downcase} #{activity.field_name} from #{activity.old_value} to #{activity.new_value}"
    end
  end
end
