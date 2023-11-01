# frozen_string_literal: true

# Syndicates apis
module V1
  class SyndicatesController < ApiController
    before_action :check_file_presence, only: %i[create]
    before_action :find_syndicate, only: %i[show]
    before_action :validate_deal_association, only: %i[show]

    def index
      success(
        I18n.t('syndicate.get.success.show'),
        SyndicateSerializer.new(Syndicate.approved.all).serializable_hash[:data].map{ |sy| sy[:attributes] }
      )
    end

    def show
      syndicate_data = SyndicateSerializer.new(@syndicate).serializable_hash[:data][:attributes]
      syndicate_data[:comments] = syndicate_comments
      syndicate_data[:attachments] = syndicate_docs
      syndicate_data[:deal] = deal_details
      syndicate_data[:thread_id] = @deal.syndicate_comment(@syndicate.id)&.id
      syndicate_data[:invite_id] = @deal.invites.find_by(id: params[:id])&.id
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

      docs = @deal.attachments.where(uploaded_by: @deal.user)
      return [] if docs.blank?

      AttachmentSerializer.new(docs).serializable_hash[:data].map {|d| d[:attributes]}
    end

    def deal_details
      {
        title: @deal.title,
        status: @deal.status
      }
    end
  end
end
