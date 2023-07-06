# frozen_string_literal: true

module UserState
  class Manager < ApplicationService
    attr_reader :user, :errors

    def initialize(user)
      @user = user
      @errors = []
    end

    def call
      @errors << I18n.t('errors.invalid_status') unless desired_status?
      @errors << I18n.t('errors.incomplete_profile') unless profile_completed?
      @errors << I18n.t('errors.doc_missing') unless attachments_completed?

      if errors.blank?
        update_profile_state
        response(I18n.t('general.success'), true)
      else
        response(errors.to_sentence, false)
      end
    end

    private

    # Will be updated based on configurations
    def attachments_completed?
      required_doc = user.user_role.attachment_configs.pluck(:id)
      attached_doc = user.attachments.pluck(:attachment_config_id)
      (required_doc - attached_doc).length.zero?
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

    def update_profile_state
      profile_states = user.profile_states
      profile_states[:attachments_completed] = true
      user.update(profile_states: profile_states, status: User.statuses[:submitted])
    end
  end
end
