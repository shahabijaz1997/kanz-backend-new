# frozen_string_literal: true

# Deal json serializer
class DealSerializer
  include JSONAPI::Serializer

  attributes :id, :target, :status, :start_at, :end_at, :submitted_at, :success_benchmark

  attribute :how_much_funded do |deal|
    deal.acheivements
  end

  attribute :details do |deal|
    if deal.startup?
      FundingRoundSerializer.new(deal.detail).serializable_hash[:data]&.fetch(:attributes)
    else
      PropertyDetailSerializer.new(deal).serializable_hash[:data]&.fetch(:attributes)
    end
  end

  attribute :features do |deal|
    FeatureSerializer.new(deal.features).serializable_hash[:data].map { |d| d&.fetch(:attributes) }
  end
  
  attribute :terms do |deal|
    TermSerializer.new(deal.terms).serializable_hash[:data].map { |d| d&.fetch(:attributes) }
  end
end
