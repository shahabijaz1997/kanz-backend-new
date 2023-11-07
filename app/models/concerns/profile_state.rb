# frozen_string_literal: true

module ProfileState
  extend ActiveSupport::Concern

  attr_accessor :step

  included do
    after_save :update_profile_state

    private

    def update_profile_state
      user = associated_user
      profile_states = user.profile_states
      profile_states[:profile_completed] = last_step?
      profile_states[:profile_current_step] = current_step
      user.update(profile_states:)
    end

    def current_step
      return step if last_step?

      self.step = step.to_i + 1
    end

    def last_step?
      self.step ||= 1
      step.to_i == MAX_STEPS["#{association_name}_profile".to_sym]
    end

    def associated_user
      public_send(association_name)
    end

    # Name of blonging persone, e.g investor, startup...
    def association_name
      self.class.name.underscore.gsub('_profile', '')
    end
  end

  class_methods do
    # Class methods here
  end
end
