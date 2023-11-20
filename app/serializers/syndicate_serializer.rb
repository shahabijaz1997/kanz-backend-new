# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attribute :id, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.id
  end

  attribute :name, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.name
  end

  attribute :email, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.email
  end

  attribute :type, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.type
  end

  attribute :status, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.status
  end

  attribute :language, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.language
  end

  attribute :profile_states, if: Proc.new { |record, params| params.blank? }  do |syndicate|
    syndicate.profile_states
  end

  attribute :profile, if: Proc.new { |record, params| params.blank? } do |syndicate|
    SyndicateProfileSerializer.new(
      syndicate.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role, if: Proc.new { |record, params| params.blank? } do |user|
    user.role_title
  end

  attribute :syndicate_list, if: Proc.new { |record, params| params && params[:investor_list_view] } do |syndicate|
    {
      id: syndicate.id,
      logo: syndicate.profile&.attachment&.url
      name: syndicate.name,
      created_at: DateTime.parse(syndicate.created_at.to_s).strftime('%d/%m/%Y'),
      total_deals: syndicate.total_deals,
      active_deals: syndicate.no_active_deals,
      raising_fund: !syndicate.no_active_deals.zero?
    }
  end

  attribute :detail, if: Proc.new { |record, params| params && params[:investor_detail_view] } do |syndicate|
    {
      id: syndicate.id,
      logo: syndicate.profile&.attachment&.url
      name: syndicate.name,
      created_at: DateTime.parse(syndicate.created_at.to_s).strftime('%d/%m/%Y'),
      total_deals: syndicate.total_deals,
      active_deals: syndicate.no_active_deals,
      raising_fund: !syndicate.no_active_deals.zero?,
      profile: SyndicateProfileSerializer.new( syndicate.profile).serializable_hash[:data]&.fetch(:attributes)
    }
  end
end
