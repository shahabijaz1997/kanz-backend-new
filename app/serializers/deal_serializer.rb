# frozen_string_literal: true

# Deal json serializer
class DealSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :target, :submitted_at, :success_benchmark, :current_state, :token

  attribute :status do |deal|
    deal.humanized_enum(deal.status)
  end

  attribute :deal_type do |deal|
    deal.humanized_enum(deal.deal_type)
  end

  attribute :model do |deal|
    deal.humanized_enum(deal.model)
  end

  attribute :start_at do |deal|
    deal.start_at.present? ? Date.parse(deal.start_at.to_s).strftime('%d/%m/%Y') : ''
  end

  attribute :end_at do |deal|
    deal.end_at.present? ? Date.parse(deal.end_at.to_s).strftime('%d/%m/%Y') : ''
  end

  attribute :details do |deal|
    if deal.startup?
      FundingRoundSerializer.new(deal.funding_round).serializable_hash[:data]&.fetch(:attributes)
    else
      PropertyDetailSerializer.new(deal.property_detail).serializable_hash[:data]&.fetch(:attributes)
    end
  end

  attribute :features do |deal|
    FeatureSerializer.new(deal.features).serializable_hash[:data].map { |d| d&.fetch(:attributes) }
  end
  
  attribute :terms do |deal|
    deal.startup? ? TermSerializer.new(deal.terms).serializable_hash[:data].map { |d| d&.fetch(:attributes) } : []
  end

  attribute :external_links do |deal|
    ExternalLinkSerializer.new(deal.external_links).serializable_hash[:data].map { |d| d&.fetch(:attributes) }
  end

  attribute :raised do |deal|
    deal.raised
  end

  attribute :syndicate do |deal|
    syndicate = deal.syndicate
    if syndicate.present?
      {
        id: syndicate&.id,
        name: syndicate.name,
        logo: syndicate.profile&.attachment&.url
      }
    else
      {}
    end
  end
end
