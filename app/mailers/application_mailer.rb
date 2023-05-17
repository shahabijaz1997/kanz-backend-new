# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'kanz@example.com'
  layout 'mailer'
end
