# frozen_string_literal: true

# Fast json serializer
class SyndicateSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :type, :status, :language, :profile_states

  attribute :profile, if: Proc.new { |record, params| params && !params[:investor] } do |syndicate|
    SyndicateProfileSerializer.new(
      syndicate.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role, if: Proc.new { |record, params| params && !params[:investor] } do |user|
    user.role_title
  end

  attribute :details, if: Proc.new { |record, params| params && params[:investor] } do |syndicate|
    {
      id: syndicate.id,
      name: syndicate.name,
      created_at: DateTime.parse(syndicate.created_at.to_s).strftime('%d/%m/%Y'),
      total_deals: syndicate.total_deals,
      active_deals: syndicate.no_active_deals,
      raising_fund: !syndicate.no_active_deals.zero?
    }
  end
end
