# frozen_string_literal: true

# Fast json serializer
class SyndicateMemberSerializer
  include JSONAPI::Serializer

  attributes :id

  attribute :syndicate_id do |syndicate_member|
    syndicate_member.syndicate_group.syndicate_id
  end
  
  attribute :syndicate_group_id do |syndicate_member|
    syndicate_member.syndicate_group_id
  end

  attribute :joining_date do |syndicate_member|
    DateTime.parse(syndicate_member.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :member_name do |syndicate_member|
    syndicate_member.member&.name
  end

  attribute :member_type do |syndicate_member|
    syndicate_member.member&.type
  end

  attribute :member_id do |syndicate_member|
    syndicate_member.member_id
  end

  attribute :invested_amount do |syndicate_member|
    syndicate_member.member.invested_amount
  end

  attribute :no_investments do |syndicate_member|
    syndicate_member.member.no_investments
  end
end
