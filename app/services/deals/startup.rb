module Deals
  class Startup < ApplicationService
    attr_reader :deal

    def initialize(deal)
      @deal = deal
    end

    def call()
      round = deal.funding_round
      return {} if round.blank?

      {
        stage: round.stage,
        instrument_type: round.instrument,
        equity_type: round.equity_kind,
        safe_type: round.safe_kind,
        valuation_type: round.valuation_type,
        valuation: round.valuation,
        terms: terms,
        pitch_deck: AttachmentSerializer.new(pitch_deck).serializable_hash[:data]
      }    
    end

    private

    def terms
      terms = FieldAttribute.joins(:terms).where("terms.deal_id = #{deal.id}").pluck(:statement, :enabled, :custom_input)
      terms.map { |term| { term: term[0], is_enabled: term[1], value: term[2] }}
    end

    def pitch_deck
      deal.attachments.find_by(uploaded_by_id: deal.author_id, name: 'Investor Presentation or Pitch Deck')
    end

  end
end
