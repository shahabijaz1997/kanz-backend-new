# frozen_string_literal: true

module Notifications
  class MessageBuilder < ApplicationService
    DEAL_ACTIVITY_ACTIONS = %w[new_deal deal_update_published deal_closed].freeze
    VALUATION_ACTIVITY_ACTIONS = %w[deal_valuation_changed rental_amount_changed rental_cycle_changed].freeze
    INVITE_ACTIVITY_ACTIONS = %w[syndicate_membership syndicate_membership_invite syndicate_membership_request
                                 syndication_invite syndication_request syndicate_assigned investment_invite].freeze

    attr_reader :activity

    def initialize(activity)
      super()
      @activity = activity
    end

    def call
      generate_message
    end

    private

    def generate_message
      if invite_activity?
        activity.new_value
      elsif valuation_activity?
        field_update_message
      elsif deal_activity?
        deal_update_message
      else
        investment_message
      end
    end

    def invite_activity?
      activity.action.in?(INVITE_ACTIVITY_ACTIONS)
    end

    def valuation_activity?
      activity.action.in?(VALUATION_ACTIVITY_ACTIONS)
    end

    def deal_activity?
      activity.action.in?(DEAL_ACTIVITY_ACTIONS)
    end

    def deal_update_message
      case activity.action
      when 'new_deal'
        "#{activity.action} you from his #{activity.record_type.titlecase.downcase}"
      when 'deal_update_published'
        "published a new update on “#{activity.record.deal.title}” deal"
      when 'deal_closed'
        "deal “#{activity.record.title}” is closed"
      end
    end

    def investment_message
      message = activity.action.eql?('new_investment') ? 'new' : 'refunded'
      "#{message} investment of #{activity.record.currency} #{activity.record.amount.to_f} on " \
        "deal “#{activity.record.deal.title}”"
    end

    def field_update_message
      "modified #{activity.record_type.titlecase.downcase} #{activity.field_name} from #{activity.old_value} to #{activity.new_value}"
    end
  end
end
