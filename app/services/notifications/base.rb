module Notifications
  class Base < ApplicationService
    attr_reader :activity
    def initialize(activity)
      @activity = activity
    end

    def call
      # need to set kind and message_ar
      notification_message = message
      kind = activity.action
      recipients.each do |recipient|
        notification = Notification.new(message: notification_message,
                                        message_ar: notification_message,
                                        recipient_id: recipient.id,
                                        activity_id: activity.id,
                                        kind: kind)
        notification.save
      end
    end

    private

    def recipients
      return activity.record.investors if deal_modified?
      return activity.record.deal.investors if deal_update_published?
      return activity.record.investors if rent_changed?
      return (activity.record.classic? ? Investor.approved.active : Syndicate.approved) if deal_added?
      return [activity.record.recipient] if invited?
    end

    def deal_update_published?
      activity.record_type == 'DealUpdate' && activity.action == Activity::actions[:deal_update_published]
    end

    def rent_changed?
      Activity::actions[:rental_amount_changed] || Activity::actions[:rental_cycle_changed]
    end

    def deal_modified?
      activity.record_type == 'Deal' && activity.action == Activity::actions[:deal_valuation_changed]
    end

    def deal_added?
      activity.record_type == 'Deal' && activity.action == Activity::actions[:new_deal]
    end

    def invited?
      activity.action.in?([Activity::actions[:syndicate_membership_invite], Activity::actions[:syndicate_membership_request],
                          Activity::actions[:syndication_invite], Activity::actions[:syndication_request],
                          Activity::actions[:investment_invite]])
    end

    def message
      case activity.action
      when Activity::actions[:new_deal]
        new_deal_added
      when Activity::actions[:syndicate_membership_invite]
        syndication_invite
      when Activity::actions[:syndicate_membership_request]
        syndicate_membership_request
      when Activity::actions[:syndicate_membership]
        syndicate_membership
      when Activity::actions[:deal_update_published]
        deal_update_published
      when Activity::actions[:syndication_invite]
        syndication_invite
      when Activity::actions[:syndication_request]
        syndication_request
      when Activity::actions[:syndicate_assigned]
        syndicate_assigned
      when Activity::actions[:investment_invite]
        syndication_invite
      when Activity::actions[:deal_closed]
        deal_closed
      when Activity::actions[:deal_valuation_changed]
        field_update
      when Activity::actions[:rental_amount_changed]
        field_update
      when Activity::actions[:rental_cycle_changed]
        field_update
      when Activity::actions[:new_investment]
        new_investment
      when Activity::actions[:investment_refunded]
        investment_refunded
      end
    end

    def syndicate_membership_invite
      # pending
    end

    def syndicate_membership_request
      # pending
    end

    def syndication_request
      # pending
    end
    def syndicate_assigned
      # pending
    end

    def investment_invite
      # pending
    end

    def deal_closed
      # pending
    end

    def new_investment
      # pending
    end

    def investment_refunded
      # pending
    end

    def syndicate_membership
      "#{activity.action} you in his #{activity.record_type.titlecase.downcase}"
    end

    def deal_update_published
      "published a new update on “#{activity.record.deal.title}” deal"
    end

    def new_deal_added
      "#{activity.action} you from his #{activity.record_type.titlecase.downcase}"
    end

    def syndication_invite
      message = "to join his syndicate group" if activity.record.eventable_type == 'SyndicateGroup'
      message = "on his deal" if activity.record.eventable_type == 'Deal'
      "#{activity.action} you to #{message}"
    end

    def field_update
      "modified #{activity.record_type.titlecase.downcase} #{activity.field_name} from #{activity.old_value} to #{activity.new_value}"
    end
  end
end
