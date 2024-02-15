# frozen_string_literal: true

# Deals api's
module V1
  class DealsController < ApiController
    before_action :find_deal, only: %i[review submit documents comments sign_off investors]
    before_action :set_deal, only: %i[create]
    before_action :get_deal, only: %i[show]
    before_action :set_invite, only: %i[sign_off]
    before_action :set_features, only: %i[unique_selling_points]
    skip_before_action :authenticate_user!, only: %i[show]
    before_action :search_params, only: %i[index]

    def index
      @deals = current_user.deals.where(deal_type: params[:deal_type]).ransack(params[:search]).result
      stats = stats_by_status
      status = params[:status].in?(Deal::statuses.keys) ? params[:status] : Deal::statuses.keys
      pagy, @deals = pagy @deals.by_status(status).latest_first

      success(
        'success',
        {
          deals: DealSerializer.new(@deals).serializable_hash[:data].map { |d| simplify_attributes(d[:attributes]) },
          pagy: pagy,
          stats: stats
        }
      )
    end

    def live
      types = params[:type].in?(Deal::deal_types.keys) ? params[:type] : Deal::deal_types.keys
      pagy, deals = pagy current_user.deals.live_or_closed.by_type(types).latest_first
      success(
        'success',
        deals: DealSerializer.new(deals).serializable_hash[:data].map { |d| simplify_attributes(d[:attributes]) },
        stats: {},
        pagy: pagy
      )
    end

    def show
      if current_user
        success('Success', Deals::Overview.call(@deal, current_user))
      else
        success('Success', Deals::PublicDetails.call(@deal))
      end
    end

    def create
      response = Deals::ParamComposer.call(deal_params, @deal)
      return failure(response.message) unless response.status

      response.data.merge!(status: 'draft') if @deal.status == 'approved'
      if @deal.update(response.data)
        success('success', { id: @deal.id })
      else
        failure(@deal.errors.full_messages.to_sentence)
      end
    end

    def review
      @steppers = Stepper.where(stepper_type: STEPPERS[params[:type].to_sym]).order(:index)
      steps = Settings::ParamsMapper.call(@deal, @steppers, true)
      success('Success', steps)
    end

    def documents
      attachments = @deal.attachments.where(uploaded_by: @deal.user)
      success(
        'Success',
        AttachmentSerializer.new(attachments).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end

    def comments
      success(
        'Success',
        CommentSerializer.new(@deal.comments).serializable_hash[:data].map{|d| d[:attributes]}
      )
    end

    # Only for Syndicates and Deal Creators
    def activities
      deal = Deal.find_by(id: params[:id])
      return failure(I18n.t('deal.not_found'), 404) if deal.blank?

      activities = deal.activities
      success(
        'success',
        records: DealActivitySerializer.new(activities).serializable_hash[:data].map { |d| simplify_attributes(d[:attributes]) },
        stats: {},
        pagy: {}
      )
    end

    def submit
      if @deal.update(status: Deal.statuses[:submitted], submitted_at: Time.zone.now, current_state: {})
        DealsMailer::submission(@deal, current_user).deliver_now
        success(@deal)
      else
        failure(@deal.errors.full_messages.to_sentence)
      end
    end

    def unique_selling_points
      features = @features.map do |usp|
        {
          title: usp.title,
          description: usp.description
        }
      end
      success('success', features)
    end

    def sign_off
      Deal.transaction do
        @invite.update!(status: Invite::statuses[:approved])
        @deal.update!(syndicate: @invite.invitee, status: Deal::statuses[:live])
      end
      success('Success', @deal)
    end

    def investors
      investors = User.approved.where(type: 'Investor')
      investors = investors.active.or(User.approved.where(type: 'Syndicate')) if @deal&.classic?
      investors = investors.ransack(params[:search]).result

      invitees_ids = @deal.present? ? @deal.invites.pluck(:invitee_id) : []
      @investors = InvestorSerializer.new(investors).serializable_hash[:data].map do |d|
        d[:attributes][:already_invited] = d[:attributes][:id].in?(invitees_ids)
        d[:attributes].select { |key,_| %i[id name invested_amount no_investments already_invited].include? key }
      end
      success('success', @investors)
    end

    private

    def find_deal
      @deal = current_user.deals.or(Deal.where(syndicate_id: current_user.id)).find_by(id: params[:id])
      failure(I18n.t('deal.not_found'), 404) if @deal.blank?
    end

    def set_features
      deal = Deal.find_by(id: params[:id])
      failure(I18n.t('deal.not_found'), 404) if deal.blank?
      failure(I18n.t('deal.no_usps')) unless deal.property?
      @features = deal.features
    end

    def deal_params
      params.require(:deal).permit(:id, :deal_type, :step, fields: %i[id value index deleted])
    end

    def deal_approval_params
      params.require(:deal).permit(%i[invite_id])
    end

    def set_deal
      return failure(I18n.t('errors.exceptions.parameter_missing')) if deal_params[:id].blank? && invalid_deal_type?

      @deal = current_user.deals.find_by(id: deal_params[:id])
      @deal = @deal || current_user.deals.new(deal_type: deal_params[:deal_type])
    end

    def get_deal
      @deal = Deal.find_by(token: params[:token])
      failure(I18n.t('deal.not_found'), 404) if @deal.blank?
    end

    def invalid_deal_type?
      deal_params[:deal_type].blank? || DEAL_TYPES[deal_params[:deal_type].to_sym].blank?
    end

    def simplify_attributes(attributes)
      return attributes if attributes[:details].blank?

      attributes = attributes.merge(attributes[:details])
      attributes.delete(:details)
      attributes
    end

    def set_invite
      @invite = @deal.invites.find_by(id: deal_approval_params[:invite_id], status: Invite::statuses[:accepted])
      failure(I18n.t('invite.not_updatable')) if @invite.blank?
    end

    def stats_by_status
      hash = { all: @deals.count }
      Deal::statuses.keys.map do |status|
        hash[status] = @deals.send(status).count
      end
      hash
    end
  end
end
