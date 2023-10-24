# frozen_string_literal: true

class InvitesMailer < ApplicationMailer
  def new_invite(invite)
    prepare_attributes(invite)
    mail(to: @invitee.email, subject: 'New deal invitation')
  end

  def invite_update(invite)
    prepare_attributes(invite)
    mail(to: @invite.user.email, subject: "Invite has been #{invite.status}")
  end

  private

  def prepare_attributes(invite)
    @deal = invite.eventable
    @invite = invite
    @invitee = invite.invitee
  end
end
