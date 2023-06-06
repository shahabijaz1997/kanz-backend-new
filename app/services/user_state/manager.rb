# frozen_string_literal: true

module UserState
  class Manager < ApplicationService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      return unless desired_status? && documents_attached? && profile_completed?

      user.update(status: User.statuses[:submitted])
    end

    private

    # Will be updated based on configurations
    def documents_attached?
      user.attachments.count >= 3
    end

    def desired_status?
      user.opened? || user.reopened?
    end

    def profile_completed?
      user.profile.present? && philosophy_completed?
    end

    def philosophy_completed?
      !user.investor? || user.investment_philosophies.present?
    end
  end
end
