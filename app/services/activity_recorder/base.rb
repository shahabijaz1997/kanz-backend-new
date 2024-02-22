# frozen_string_literal: true

module ActivityRecorder
  class Base < ApplicationService
    attr_reader :record, :user, :type

    def initialize(record, user, type)
      super()
      @record = record
      @user = user
      @type = type
    end

    def call
      if type.eql?(ACTIVITY_CATEGORIES[:invite])
        change_details = Invite.call(record, user)
      end
      record_activity(change_details)
    end

    private

    def record_activity(details)
      Activity.create!(field_name: details[:field_name],
                       old_value: details[:old_value],
                       new_value: details[:new_value],
                       action: details[:action],
                       user:,
                       record:)
    end
  end
end
