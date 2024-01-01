# frozen_string_literal: true

module SpvStepper
  extend ActiveSupport::Concern

  included do
    after_save :update_step

    private

    def update_step

    end

    def current_step
      return step if last_step?

      self.step = step.to_i + 1
    end

    def last_step?
      self.step ||= 1
      step.to_i == MAX_STEPS["#{class.name}".to_sym]
    end

    def associated_user
      public_send(association_name)
    end
  end

  class_methods do
    # Class methods here
  end
end
