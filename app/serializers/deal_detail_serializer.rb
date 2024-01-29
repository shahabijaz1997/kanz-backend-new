# frozen_string_literal: true

# Deal Detail json serializer
class DealDetailSerializer
  include JSONAPI::Serializer

  attributes :id, :title, :description, :target, :token

  attribute :status do |deal|
    deal.humanized_enum(deal.status)
  end

  attribute :deal_type do |deal|
    deal.humanized_enum(deal.deal_type)
  end

  attribute :details do |deal|
    details(deal)
  end

  private 

  class << self

    def details(deal)
      deal.startup? ? startup_details(deal) : property_details(deal)
    end

    def startup_details(deal)
      round = deal.funding_round
      return if round.blank?

      round.equity? ? equity_attributes(round, deal) : safe_attributes(round, deal)
    end

    def equity_attributes(round, deal)
      {
        round: round.stage,
        instrument_type: round.instrument,
        equity_type: round.equity_kind,
        valuation: round.valuation,
        valuation_type: round.valuation_type
      }.merge(deal_terms(deal))
    end

    def safe_attributes(round, deal)
      {
        instrument_type: round.instrument,
        safe_type: round.safe_kind
      }.merge(deal_terms(deal))
    end

    def deal_terms(deal)
      terms = deal.terms
      return {} if terms.blank?

      terms.map { |term| [term.statement, term.value] }.to_h
    end

    def property_details(deal)
      property_details = deal.property_detail
      return if property_details.blank?

      {
        location: property_details.location_detail,
        size: "#{property_details.size} #{I18n.t('sqft')}",
        country: property_details.country_name,
        state: property_details.state,
        city: property_details.city,
        is_rental: property_details.is_rental,
        rental_period_id: property_details.rental_duration,
        rental_amount: property_details.rental_amount,
        dividend_yield: property_details.dividend_yield,
        yearly_appreciation: property_details.yearly_appreciation
      }
    end
  end
end
