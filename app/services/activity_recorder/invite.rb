module ActivityRecorder
  class Invite < ApplicationService
    attr_reader :record, :user 

    def initialize(record, user)
      @record = record
      @user = user
    end

    def call
      record_activity
    end

    private

    def record_activity
      activity = Activity.new(new_value: record.invitee_id),
                              action: :deal_update_published)
      activity.user = user
      activity.record = record
      activity.save!
    end
  end
end
