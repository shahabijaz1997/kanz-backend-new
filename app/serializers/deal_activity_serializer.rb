# frozen_string_literal: true

# Its a mixup of invites for investments and actual investment
class DealActivitySerializer
  include JSONAPI::Serializer

  attribute :invite_id do |invite|
    invite.id
  end

  attribute :status do |invite|
    invite.status
  end

  attribute :investor do |invite|
    {
      id: invite.invitee_id,
      name: invite.invitee.name
    }
  end

  attribute :date do |invite|
    investment = Investment.find_by(deal_id: invite.eventable_id, user_id: invite.invitee_id)
    created_date = investment.present? ? investment.created_at : invite.created_at
    Date.parse(created_date.to_s).strftime('%d/%m/%Y')
  end

  attribute :amount do |invite|
    investment = Investment.find_by(deal_id: invite.eventable_id, user_id: invite.invitee_id)
    investment.present? ? investment.amount : 0.00
  end
end
