# frozen_string_literal: true

# Investor persona
module V1
  class InvitesController < ApiController
    before_action :set_deal, except: %i[index]
    before_action :find_invite, :validate_invite_status, only: %i[update]

    # GET
    # /1.0/deals/:deal_id/invites
    # /1.0/users/:user_id/invites
    # /1.0/invitees/:invitee_id/invites
    def index
      success(
        'success',
        InviteSerializer.new(
          invites
        ).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end

    #POST /1.0/deals/:deal_id/invites
    def create
      invite = current_user.invites.new(invite_params)
      invite.eventable = @deal

      if invite.save
        success('success', invite)
      else
        failure(invite.errors.full_messages.to_sentence)
      end
    end

    #POST /1.0/invites/:id
    def update
      Invite.transaction do
        upload_attachments
        @invite.update!(status: invite_update_params[:status])
      end
      success('success', @invite)
    end

    def syndicate_group
      eventable = { eventable_id: @deal.id, eventable_type: 'Deal' }
      Invite.transaction do
        members_params = current_user.syndicate_members.pluck(:id).map {|id| { invitee_id: id }.merge(eventable)}
        current_user.invites.create!(members_params)
      end
      success('successfuly sent an invite to all group members')
    end

    private

    def invite_params
      params.require(:invite).permit(%i[message invitee_id])
    end

    def invite_update_params
      params.require(:invite).permit(:status, deal_attachments: %i[file attachment_kind])
    end

    def set_deal
      @deal = Deal.find_by(id: params[:deal_id])
      failure('Unable to find deal', 404) if @deal.blank?
    end

    # current user can update the invites he received
    def find_invite
      @invite = @deal.invites.find_by(id: params[:id], invitee_id: current_user.id)
      failure('Unable to find invite', 404) if  @invite.blank?
    end

    def invites
      status = params[:status].in?(Invite::statuses.keys) ? params[:status] : Invite::statuses.keys
      invites = Invite.where(eventable_type: 'Deal').where(
        'eventable_id= ? OR invitee_id= ? OR user_id= ?',
        params[:deal_id], params[:invitee_id], params[:user_id]
      ).active.by_status(status).latest_first
    end

    def validate_invite_status
      status = invite_update_params[:status]
      return if Invite::statuses[status].present? && status == 'accepted'

      failure('invalid status', 400)
    end

    def upload_attachments
      return if invite_update_params[:deal_attachments].blank?

      invite_update_params[:deal_attachments].values.each do |attachment_params|
        @deal.attachments.create!(attachment_params.merge(uploaded_by: current_user))
      end
    end
  end
end
