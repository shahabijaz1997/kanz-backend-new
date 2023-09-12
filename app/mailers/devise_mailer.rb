# frozen_string_literal: true

class DeviseMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts = {})
    @name = record.name
    mail = super
    mail.subject = 'One Time Password'
    mail
  end
end
