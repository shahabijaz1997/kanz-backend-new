# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    mail = super
    mail.subject = 'Confirmation instructions for ${record.name}'
    mail
  end
end
