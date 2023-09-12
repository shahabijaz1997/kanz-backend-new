# frozen_string_literal: true

module Investors
  class SwitchRole < ApplicationService
    attr_reader :investor

    def initialize(investor)
      @investor = investor
    end

    def call
      return if investor.reopened?
      update_state
      remove_profile
      remove_investment_philosophies
      remove_attachments
    end

    private

    def update_state
      profile_states = investor.profile_states
      profile_states[:investor_type] = investor.role_title
      profile_states[:profile_completed] = false
      profile_states[:questionnaire_completed] = false
      profile_states[:questionnaire_steps_completed] = 0
      profile_states[:attachments_completed] = false
      investor.update(profile_states: profile_states)
    end

    def remove_profile
      investor.profile.destroy! if investor.profile.present?
    end

    def remove_investment_philosophies
      investor.investment_philosophies.destroy_all if investor.investment_philosophies.present?
    end

    def remove_attachments
      investor.attachments.destroy_all if investor.attachments.present?
    end
  end
end
