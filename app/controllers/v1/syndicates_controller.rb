# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApiController
    before_action :check_file_presence, only: %i[create]
    before_action :find_syndicate, :validate_deal_association, only: %i[show]
    before_action :search_params, only: %i[index deals all]
    before_action :authorize_role!, :extract_syndicates, only: %i[all]

    def index
      deal = Deal.find_by(id: params[:deal_id])
      syndicates = Syndicate.approved.where.not(id: deal.invites.pluck(:invitee_id)).ransack(params[:search]).result

      success(
        I18n.t('syndicate.get.success.show'),
        SyndicateSerializer.new(syndicates).serializable_hash[:data].map{ |sy| sy[:attributes] }
      )
    end

    def all
      pagy, @syndicates = pagy @syndicates.ransack(params[:search]).result
      syndicates = SyndicateListSerializer.new(@syndicates).serializable_hash[:data].map do |sy|
        sy[:attributes][:invite] = invite(sy[:attributes][:id])
        sy[:attributes][:membership_status] = membership_status(sy[:attributes][:id])
        sy[:attributes]
      end

      success(
        I18n.t('syndicate.get.success.show'),
        {
          records: syndicates,
          pagy: pagy,
          stats: {}
        }
      )
    end

    def show
      syndicate_data = SyndicateDetailSerializer.new(@syndicate).serializable_hash[:data][:attributes]

      if current_user.investor?
        membership = @syndicate.membership(current_user.id)
        invite = invite(syndicate_data[:id])
        syndicate_data[:is_member] = membership.present?
        syndicate_data[:membership_id] = membership&.id
        syndicate_data[:is_invited] = invite.present?
        syndicate_data[:invite] = invite(syndicate_data[:id])
      else
        syndicate_data = additional_attributes(syndicate_data) if params[:deal_id].present?
      end

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
      status = params[:status].in?(Deal::statuses.keys) ? params[:status] : Deal::statuses.keys
      @deals = Deal.syndicate_deals.where(status: status).ransack(params[:search]).result
      stats = stats_by_deal_type
      pagy, @deals = pagy @deals.where(deal_type: (params[:deal_type] || Deal::deal_types.keys)).latest_first
      success(
        'success',
        {
          deals: DealSerializer.new(@deals).serializable_hash[:data].map { |d| simplify_attributes(d[:attributes]) },
          stats: stats,
          pagy: pagy
        }
      )
    end

    private

    def profile_params
      return [] unless params[:syndicate_profile][:step].to_i.in?([1,2])

      if params[:syndicate_profile][:step].to_i == 1
        params.require(:syndicate_profile).permit(
          :step, :have_you_ever_raised, :raised_amount, :no_times_raised, :profile_link,
          :dealflow, :about, region_ids: [], industry_ids: []
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
      failure(I18n.t('syndicate.not_found'), 404) if @syndicate.blank?
    end

    def validate_deal_association
      return if params[:deal_id].blank?

      @deal = Deal.find_by(id: params[:deal_id])
      failure(I18n.t('deal.not_found'), 404) if @deal.blank?
      @invite = @deal.invites.find_by(invitee: params[:id])
      failure(I18n.t('invite.not_found'), 404) if @invite.blank?
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
      data[:thread_id] = thread_id
      invite = @deal.invites.find_by(invitee_id: params[:id])
      data[:invite_id] = invite&.id
      data[:status] = invite&.humanized_enum(invite&.status)

      data
    end

    def deal_details
      {
        id: @deal.id,
        title: @deal.title,
        status: @deal.humanized_enum(@deal.status)
      }
    end

    def extract_syndicates
      @syndicates = Syndicate.approved
      @syndicates = my_syndicates if params[:mine].present?
      @syndicates = applied_or_received_invitation if params[:pending_invite]
    end

    def my_syndicates
      @syndicates.joins(syndicate_group: :syndicate_members).where(syndicate_members: { member_id: current_user.id })
    end

    def applied_or_received_invitation
      @syndicates.joins(syndicate_group: :invites).where("invites.status = ? and invites.invitee_id = ? or invites.user_id =?",
                                                         Invite::statuses[:pending], current_user.id, current_user.id)
    end

    def simplify_attributes(attributes)
      return attributes if attributes[:details].blank?

      attributes = attributes.merge(attributes[:details])
      attributes.delete(:details)
      attributes
    end

    def stats_by_deal_type
      {
        all: @deals.count,
        property: @deals.property.count,
        startup: @deals.startup.count
      }
    end

    def thread_id
      @deal.syndicate_comment(@syndicate.id)&.id || @deal.syndicate_and_creator_discussion(@syndicate.id)&.first&.id
    end

    def membership_status(syndicate_id)
      syndicate_group = SyndicateGroup.find_by(syndicate_id: syndicate_id)
      return I18n.t('statuses.member') if syndicate_group.syndicate_members.exists?(member_id: current_user.id)
      if Invite.exists?(user_id: syndicate_id, invitee_id: current_user.id, eventable: syndicate_group)
        I18n.t('statuses.invited')
      elsif Invite.exists?(user_id: current_user.id, invitee_id: syndicate_id, eventable: syndicate_group)
        I18n.t('statuses.invited')
      else
        I18n.t('statuses.not_invited')
      end
    end

    def invite(syndicate_id)
      syndicate_group = SyndicateGroup.find_by(syndicate_id: syndicate_id)
      invite = Invite.find_by(user_id: syndicate_id, invitee_id: current_user.id, eventable: syndicate_group)
      invite ||= Invite.find_by(user_id: current_user.id, invitee_id: syndicate_id, eventable: syndicate_group)
      return nil if invite.blank?
      {
        id: invite.id,
        created_at: DateTime.parse(invite.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p'),
        status: invite.humanized_enum(invite.status)
      }
    end
  end
end
