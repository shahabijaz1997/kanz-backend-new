# frozen_string_literal: true

# Fast json serializer
class InviteSerializer
  include JSONAPI::Serializer

  attributes :id, :message, :status

  attribute :sent_at do |invite|
    DateTime.parse(invite.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end

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
      token: deal.token,
      title: deal.title,
      target: deal.target,
      type: deal.deal_type,
      end_at: (deal.end_at.present? ? Date.parse(deal.end_at.to_s).strftime('%d/%m/%Y') : ''),
      comment: deal.syndicate_comment(invite.invitee_id)&.message,
      docs: AttachmentSerializer.new(deal.syndicate_docs(invite.invitee_id)).serializable_hash[:data].map {|d| d[:attributes]}
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
