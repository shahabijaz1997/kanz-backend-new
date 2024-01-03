# frozen_string_literal: true

# Fast json serializer
class SyndicateMemberSerializer
  include JSONAPI::Serializer
  attributes :id

  attribute :syndicate_group_id do |syndicate_member|
    syndicate_member.syndicate_group_id
  end

  attribute :syndicate_id do |syndicate_member|
    syndicate_member.syndicate_group&.syndicate_id
  end

  attribute :is_member do |syndicate_member|
    syndicate_member.persisted?
  end

  attribute :member_id do |syndicate_member|
    syndicate_member.member_id
  end

  attribute :member_name do |group|
    group.member.name
  end

  attribute :profile_pic do |group|
    group.member.profile_pic
  end

  attribute :investor_type do |group|
    investor = group.member
    I18n.locale == :en ? investor.role_title : investor.role_title_ar
  end

  attribute :accreditation do |group|
    profile = group.member.profile
    profile&.accreditation
  end

  attribute :role do |syndicate_member|
    I18n.locale == :en ? syndicate_member.role.title : syndicate_member.role.title_ar
  end

  attribute :joining_date do |syndicate_member|
    syndicate_member.created_at.present? ? DateTime.parse(syndicate_member.created_at.to_s).strftime('%d/%m/%Y') : nil
  end

  attribute :invested_amount do |syndicate_member|
    syndicate_member.member.invested_amount
  end

  attribute :no_investments do |syndicate_member|
    syndicate_member.member.no_investments
  end

  attribute :invite_id do |syndicate_member|
    nil
  end

  attribute :invite_status do |syndicate_member|
    nil
  end
end
