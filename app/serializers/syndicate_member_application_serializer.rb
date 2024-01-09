# frozen_string_literal: true

# Fast json serializer
class SyndicateMemberApplicationSerializer
  include JSONAPI::Serializer
  attributes :id

  attribute :invitee_name do |invite|
    invite.user.name
  end

  attribute :profile_pic do |invite|
    invite.user.profile_pic
  end

  attribute :status do |invite|
    invite.humanized_enum(invite.status)
  end

  attribute :message do |invite|
    invite.message
  end

  attribute :discovery_method do |invite|
    invite.humanized_enum(invite.discovery_method)
  end

  attribute :sent_at do |invite|
    DateTime.parse(invite.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end

  attribute :invested_amount do |invite|
    invite.user.invested_amount
  end

  attribute :no_investments do |invite|
    invite.user.no_investments
  end
end
