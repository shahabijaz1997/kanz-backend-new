# frozen_string_literal: true

class InvestmentsMailer < ApplicationMailer
  def completed(investment, deal)
    @investment = investment
    @deal = deal
    mail.subject = "Your investment on deal #{deal.title} is accepted"
    mail.to = investment.user.email
    mail
  end
end
