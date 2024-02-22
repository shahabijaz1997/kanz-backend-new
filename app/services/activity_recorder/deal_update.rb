# frozen_string_literal: true

module ActivityRecorder
  class DealUpdate < ApplicationService
    attr_reader :deal_update, :user

    def initialize(deal_update, user)
      super()
      @deal_update = deal_update
      @user = user
    end

    def call
      record_activity
    end

    private

    def record_activity
      activity = Activity.new(new_value: deal_update.description.truncate(STRING_LENGTH),
                              action: Activity.actions[:deal_update_published])
      activity.user = user
      activity.record = deal_update
      activity.save!
    end
  end
end
