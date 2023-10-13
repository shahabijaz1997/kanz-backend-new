# frozen_string_literal: true

class DealsMailer < ApplicationMailer
  def submission(deal, user)
    @deal = DealSerializer.new(deal).serializable_hash[:data][:attributes]
    @user = @user
    mail.subject = 'A new deal is submitted'
    to_list = [user.email] + csm_email_list
    mail.to = to_list
    mail
  end

  private

  def csm_email_list
    csm_role_id = AdminRole.find_by(title: "Customer Support Rep").id
    AdminUser.where( admin_role_id: csm_role_id).pluck(:email)
  end
end
