# frozen_string_literal: true

class UsersResponse < ApplicationRecord
  belongs_to :question
  belongs_to :user

  after_save :update_profile_state

  private

  def update_profile_state
    profile_states = user.profile_states
    profile_states[:questionnaire_steps_completed] = question.step
    profile_states[:questionnaire_completed] = question.step == 5
    user.update(profile_states:)
  end
end
