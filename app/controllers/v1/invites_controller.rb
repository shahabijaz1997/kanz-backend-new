# frozen_string_literal: true

# Investor persona
module V1
  class InvitesController < ApiController
    before_action :set_deal, only: %i[create index]

    #GET /1.0/deals/:deal_id/invites
    def index
      success(
        'success',
        InviteSerializer.new(@deal.invites).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end

    #POST /1.0/deals/:deal_id/invites
    def create
      invite = current_user.invites.new(invite_params.merge(eventable_id: @deal.id, eventable_type: 'Deal'))

      if invite.save
        success('success', invite)
      else
        failure(invite.errors.full_messages.to_sentence)
      end
    end

    private

    def invite_params
      params.require(:invite).permit(%i[message invitee_id] )
    end

    def set_deal
      @deal = Deal.find_by(id: params[:deal_id])
    end
  end
end
