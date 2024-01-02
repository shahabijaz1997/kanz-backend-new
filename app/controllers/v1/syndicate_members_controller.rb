# frozen_string_literal: true

# Syndicate Member Apis
module V1
  class SyndicateMembersController < ApiController
    before_action :find_invite, only: %i[create destroy]
    before_action :find_syndicate_member, only: %i[destroy]
    before_action :search_params, only: %i[index]

    def index
      @syndicate_members = current_user.syndicate_members.ransack(params[:search]).result
      stats = stats_by_role
      pagy, @syndicate_members = pagy @syndicate_members.latest_first, max_items: 8
      success(
        'success',
        {
          records: SyndicateMemberSerializer.new(@syndicate_members).serializable_hash[:data].map {|d| d[:attributes]},
          stats: stats_by_role,
          pagy: pagy
        }
      )
    end

    def create
      member = @invite.eventable.syndicate_members.build(member_params)
      member.save ? success(I18n.t("syndicate_member.added")) : failure(member.errors.full_messages.to_sentence)
    end

    def destroy
      return success(I18n.t("syndicate_member.removed_from_group")) if @syndicate_member.destroy
      
      failure(@syndicate_member.errors.full_messages.to_sentence)
    end

    private

    def find_invite
      @invite = Invite.syndicate_membership.find_by(id: params[:invite_id], invitee_id: current_user.id)
      failure(I18n.t("invite.not_found")) if @invite.blank?
    end

    def member_params
      { 
        member_id: current_user.syndicate? ? @invite.user_id : @invite.invitee_id
      }
    end

    def find_syndicate_member
      @syndicate_member = @syndicate.syndicate_members.find_by(id: params[:id])

      failure(I18n.t("syndicate_member.not_found")) if @syndicate_member.blank?
    end

    def stats_by_role
      {
        all: @syndicate_members.count,
        lps: @syndicate_members.where(role_id: Role.find_by(name: 'Limited Partner')).count,
        gps: @syndicate_members.where(role_id: Role.find_by(name: 'General Partner')).count
      }
    end
  end
end
