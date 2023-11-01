# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('FROM_EMAIL', nil)
  layout 'mailer'

  rescue_from StandardError do |excep|
    Rails.logger.error ([excep.message]+excep.backtrace).join($/)
  end
end
