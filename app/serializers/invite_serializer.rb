# frozen_string_literal: true

# Fast json serializer
class InviteSerializer
  include JSONAPI::Serializer

  attributes :message, :status

  attribute :invited_by do |invite|
    invite.user.name
  end

  attribute :invite_expiry do |invite|
    Date.parse(invite.expire_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :deal do |invite|
    deal = invite.eventable
    {
      id: deal.id,
      title: deal.title,
      target: deal.target,
      end_at: Date.parse(deal.end_at.to_s).strftime('%d/%m/%Y')
    }
  end

  attribute :invitee do |invite|
    {
      id: invite.invitee.id,
      name: invite.invitee.name,
      type: invite.invitee.syndicate? ? 'syndicate' : 'investor'
    }
  end
end
