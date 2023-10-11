# frozen_string_literal: true

# Deal json serializer
class DealSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :target, :status, :start_at, :end_at, :submitted_at, :success_benchmark, :current_state

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
end
