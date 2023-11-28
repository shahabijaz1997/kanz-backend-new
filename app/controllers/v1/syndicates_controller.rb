# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApiController
    before_action :check_file_presence, only: %i[create]
    before_action :find_syndicate, :validate_deal_association, only: %i[show]
    before_action :authorize_role!, :extract_synidcates, only: %i[all]

    def index
      deal = Deal.find_by(id: params[:deal_id])
      deal_invitees_ids = deal.invites.pluck(:invitee_id)
      success(
        I18n.t('syndicate.get.success.show'),
        SyndicateSerializer.new(
          Syndicate.approved.where.not(id: deal_invitees_ids), { params: { investor: false }}
        ).serializable_hash[:data].map{ |sy| sy[:attributes] }
      )
    end

    def all
      success(
        I18n.t('syndicate.get.success.show'),
        SyndicateSerializer.new(@syndicates, { params: { investor_list_view: current_user.investor? }}).
          serializable_hash[:data].map do |sy|
            sy.present? ? (sy[:attributes].present? ? sy[:attributes][:syndicate_list] : sy[:attributes]) : []
          end
      )
    end

    def show
      syndicate_data = SyndicateSerializer.new(
        @syndicate,
        {
          params: {
            investor_detail_view: current_user.investor?
          }
        }
      ).serializable_hash[:data][:attributes]
      if current_user.investor?
        syndicate_data = syndicate_data[:detail]
        syndicate_data[:following] = current_user.following?(@syndicate.id)
      end
      syndicate_data = additional_attributes(syndicate_data) if params[:deal_id].present?
      success(I18n.t('syndicate.get.success.show'), syndicate_data)
    end

    def create
      profile = current_user.profile || SyndicateProfile.new(syndicate_id: current_user.id)
      SyndicateProfile.transaction do
        profile.update!(profile_params.except(:logo))
        Attachment.upload_file(profile, profile_params[:logo]) if profile_params[:logo].present?
      end
      success(I18n.t('syndicate.update.success'))
    rescue StandardError => e
      failure(profile.errors.full_messages.to_sentence.presence || e.message)
    end

    def deals
      @deals = Deal.syndicate_deals.latest_first
      success(
        'success',
        DealSerializer.new(@deals).serializable_hash[:data].map { |d| simplify_attributes(d[:attributes]) }
      )
    end

    private

    def profile_params
      return [] unless params[:syndicate_profile][:step].to_i.in?([1,2])

      if params[:syndicate_profile][:step].to_i == 1
        params.require(:syndicate_profile).permit(
          :step, :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link,
          :dealflow, region_ids: [], industry_ids: []
        )
      else
        params.require(:syndicate_profile).permit(:step, :name, :tagline, :logo)
      end
    end

    def check_file_presence
      return if current_user.profile&.attachment || params[:syndicate_profile][:step].to_i == 1

      failure(I18n.t('errors.exceptions.file_missing')) if profile_params[:logo].blank?
    end

    def find_syndicate
      @syndicate = Syndicate.find_by(id: params[:id])
      failure('No syndicate found', 404) if @syndicate.blank?
    end

    def validate_deal_association
      return if params[:deal_id].blank?

      @deal = Deal.find_by(id: params[:deal_id])
      failure('Deal not found', 404) if @deal.blank?
      @invite = @deal.invites.find_by(invitee: params[:id])
      failure('No invitation found', 404) if @invite.blank?
    end

    def syndicate_comments
      return if @invite.blank?

      comments = @deal.syndicate_and_creator_discussion(@syndicate.id)
      return [] if comments.blank?

      CommentSerializer.new(comments).serializable_hash[:data].map{|d| d[:attributes]}
    end

    def syndicate_docs
      return if @invite.blank?

      docs = @deal.attachments.where(uploaded_by: @syndicate)
      return [] if docs.blank?

      AttachmentSerializer.new(docs).serializable_hash[:data].map {|d| d[:attributes]}
    end

    def additional_attributes(data)
      data[:comments] = syndicate_comments
      data[:attachments] = syndicate_docs
      data[:deal] = deal_details
      data[:thread_id] = @deal.syndicate_comment(@syndicate.id)&.id
      data[:invite_id] = @deal.invites.find_by(invitee_id: params[:id])&.id
      data[:status] = @deal.invites.find_by(invitee_id: params[:id])&.status

      data
    end

    def deal_details
      {
        id: @deal.id,
        title: @deal.title,
        status: @deal.status
      }
    end

    def extract_synidcates
      @syndicates = Syndicate.approved
      if params[:followed].present?
        syndicate_ids = current_user.syndicate_members.pluck(:syndicate_id)
        @syndicates = Syndicate.approved.where(id: syndicate_ids)
      end
    end
  end
end
