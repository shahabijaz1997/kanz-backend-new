module Deals
  class Overview < ApplicationService
    attr_reader :deal, :user
    def initialize(deal, user)
      @deal = deal
      @user = user
    end

    def call
      user.syndicate? ? syndicate_deal_params : deal_params
    end

    private

    def syndicate_deal_params
      deal_params.merge(docs).merge(comments).merge(invite)
    end

    def deal_params
      params = {
        id: deal.id,
        raised: total_raised,
        committed: total_committed,
        investors: total_investors,
        category: deal.deal_type,
        selling_price: deal.target,
        title: deal.title,
        description: deal.description,
        status: deal.status,
        start_at: deal.start_at,
        end_at: deal.end_at,
        token: deal.token
      }

      additional_params = deal.startup? ? startup_params : property_params
      params.merge(additional_params)
    end

    def startup_params
      round = deal.funding_round
      return {} if round.blank?

      {
        stage: round.stage,
        instrument_type: round.instrument,
        equity_type: round.equity_kind,
        safe_type: round.safe_kind,
        valuation_type: round.valuation_type,
        valuation: round.valuation,
      }
    end

    def property_params
      property_detail = deal.property_detail
      return {} if property_detail.blank?

      {
        expected_dividend_yield: property_detail.dividend_yeild,
        expected_annual_return: property_detail.yearly_appreciation,
        size: property_detail.size,
        features: property_features(property_detail),
        address: address(property_detail),
        unique_selling_points: property_usps,
        external_links: external_links,
        terms: terms
      }
    end

    def property_features(features)
      feature = {}
      feature[:has_bedrooms] = features.has_bedrooms
      feature[:bedrooms] = features.no_bedrooms if features.has_bedrooms
      feature[:has_kitchen] = features.has_kitchen
      feature[:kitchen] = features.no_kitchen if features.has_kitchen
      feature[:has_washroom] = features.has_washroom
      feature[:washrooms] = features.no_washrooms if features.has_washroom
      feature[:has_parking] = features.has_parking
      feature[:parking_space] = features.parking_capacity if features.has_parking
      feature[:has_swimming_pool] = features.has_swimming_pool
      feature[:swimming_pool] = features.swimming_pool_type if features.has_swimming_pool
      feature[:is_rental] = features.is_rental
      feature[:rental_amount] = features.rental_amount if features.is_rental
      feature[:rental_period] = features.rental_duration if features.is_rental

      feature
    end

    def address(property_detail)
      {
        street_address: property_detail.street_address,
        building_name: property_detail.building_name,
        area: property_detail.area,
        city: property_detail.city,
        state: property_detail.state,
        country_name: property_detail.country_name
      }
    end

    def property_usps
      deal.features.map do |usp|
        {
          title: usp.title,
          description: usp.description
        }
      end
    end

    def external_links
      deal.external_links.map do |link|
        link.url
      end
    end

    def terms
      FieldAttribute.find_by(field_mapping: 'agreed_with_kanz_terms')&.description
    end

    def docs
      docs = deal.attachments.where(uploaded_by: deal.user)
      return {} if docs.blank?

      { docs: AttachmentSerializer.new(docs).serializable_hash[:data].map {|d| d[:attributes]} }
    end

    def comments
      comments = deal.comments.where('author_id=? OR recipient_id=?', user.id, user.id)
      return {} if comments.blank?

      {
        comments: CommentSerializer.new(comments).serializable_hash[:data].map {|d| d[:attributes]},
        thread_id: deal.syndicate_comment(user.id)&.id
      }
    end

    def invite
      invite = deal.invites.find_by(invitee_id: user.id)
      return {} if invite.blank?

      {
        invite: {
          id: invite.id,
          status: (invite.expired? ? 'expired' : invite.status),
          invited_by: invite.user.name
        }
      }
    end

    def total_raised
      # how_much_funded
      # Implement to calculate total raised from invoices
      0
    end

    def total_committed
      # Implement to calculate total committed from comitments, Need to decide 
      0
    end

    def total_investors
      # investors.count
      0
    end
  end
end
