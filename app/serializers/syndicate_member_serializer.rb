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

  attribute :member_id do |syndicate_member|
    syndicate_member.member_id
  end

  attribute :member_name do |group|
    group.member.name
  end

  attribute :role do |syndicate_member|
    I18n.locale == :en ? syndicate_member.role.title : syndicate_member.role.title_ar
  end

  attribute :joining_date do |syndicate_member|
    DateTime.parse(syndicate_member.created_at.to_s).strftime('%d/%m/%Y')
  end

  # attribute :invested_amount do |syndicate_member|
  #   syndicate_member.member.invested_amount
  # end

  # attribute :no_investments do |syndicate_member|
  #   syndicate_member.member.no_investments
  # end
end
