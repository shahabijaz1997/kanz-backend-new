# frozen_string_literal: true

module ActivityRecorder
  class Invite < ApplicationService
    attr_reader :record, :user

    def initialize(record, user)
      super()
      @record = record
      @user = user
    end

    def call
      action = activity_type
      {
        field_name: nil,
        old_value: nil,
        new_value: send(action),
        action: Activity.actions[action]
      }
    end

    private

    def activity_type
      return :investment_invite if record.investment?

      syndication_invite_type if record.syndication?
      syndicate_membership_invite_type if record.syndicate_membership?
    end

    def syndication_invite_type
      return :syndicate_assigned if record.approved?
      return :syndication_invite if user.syndicate?

      :syndication_request
    end

    def syndicate_membership_invite_type
      return :syndicate_membership if record.accepted?
      return :syndicate_membership_invite if user.syndicate?

      :syndicate_membership_request
    end

    def syndication_invite
      "invited you to be lead investor on #{record.eventable.title} deal"
    end

    def syndication_request
      "requested to lead the fundraising process on #{record.eventable.title} deal"
    end

    def syndicate_assigned
      "assigned as lead investor on #{record.eventable.title}"
    end

    def syndicate_membership_invite
      "invited you to join the syndicate group #{record.eventable.title}"
    end

    def syndicate_membership_request
      "requested to join your syndicate group #{record.eventable.title}"
    end

    def syndicate_membership
      "you are now member of syndicate group #{record.eventable.title}"
    end

    def investment_invite
      "invited you to invest on #{record.eventable.title} deal"
    end
  end
end
