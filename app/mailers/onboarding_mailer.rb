# frozen_string_literal: true

class OnboardingMailer < ApplicationMailer
  def status_changed(user)
    @user = user
    mail.subject = 'Application Status Update'
    mail.to = @user.email
    mail
  end
end
