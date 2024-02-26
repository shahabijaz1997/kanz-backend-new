# frozen_string_literal: true

module DealState
  extend ActiveSupport::Concern

  attr_accessor :step

  included do
    after_save :update_current_state

    private

    def update_current_state
      current_state['current_step'] = current_step
      current_state['submitted'] = submitted?
      update_column(:current_state, current_state)
    end

    def current_step
      submitted? ? 0 : step
    end

    def steps
      steps = submitted? ? [] : (current_state['steps'] || [])
      current_state['steps'] = steps
      current_state['steps'] = (current_state['steps'] | [step].compact)
    end
  end
end
