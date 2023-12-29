# frozen_string_literal: true

# Fast json serializer
class SyndicateDetailSerializer < SyndicateSerializer
  attributes :id, :name

  attribute :logo do |syndicate|
    syndicate.profile&.attachment&.url
  end

  attribute :created_at do |syndicate|
    DateTime.parse(syndicate.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :total_deals do |syndicate|
    syndicate.total_deals
  end

  attribute :active_deals do |syndicate|
    syndicate.no_active_deals
  end

  attribute :raising_fund do |syndicate|
    !syndicate.no_active_deals.zero?
  end

  attribute :no_times_raised do |syndicate|
    syndicate.no_investments
  end

  attribute :raised_amount do |syndicate|
    syndicate.invested_amount
  end

  attribute :profile do |syndicate|
    SyndicateProfileSerializer.new( syndicate.profile).serializable_hash[:data]&.fetch(:attributes)
  end
end
