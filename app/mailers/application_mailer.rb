# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_EMAIL', nil)
  layout 'mailer'
end
