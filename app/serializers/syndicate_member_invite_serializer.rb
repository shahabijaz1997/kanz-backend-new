# frozen_string_literal: true

# Fast json serializer
class SyndicateMemberInviteSerializer
  include JSONAPI::Serializer
  attributes :id

  attribute :invitee_name do |invite|
    invite.invitee.name
  end

  attribute :profile_pic do |invite|
    invite.invitee.profile_picture_url
  end

  attribute :status do |invite|
    invite.humanized_enum(invite.status)
  end
  
  attribute :sent_at do |invite|
    DateTime.parse(invite.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end
end
