# frozen_string_literal: true

# Syndicate Member Apis
module V1
  class SyndicateMembersController < ApiController
    before_action :find_invite, only: %i[destroy accept_invite]
    before_action :find_syndicate_member, only: %i[show update destroy]
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

    def investors
      invite_ids = current_user.syndicate_group.invites.pluck(:user_id) + current_user.syndicate_group.invites.pluck(:invitee_id)
      invite_ids = Investor.where(id: invite_ids).pluck(:id)
      member_ids = current_user.syndicate_group.syndicate_members.pluck(:member_id) + invite_ids
      investors = Investor.approved.where.not(id: member_ids)
      pagy, investors = pagy Investor.approved.where.not(id: member_ids).ransack(params[:search]).result
      investors = InvestorListSerializer.new(investors).serializable_hash[:data].map { |d| d[:attributes] }

      success('success',
        {
          records: investors,
          pagy: pagy
        }
      )
    end

    def applications
      invites = current_user.syndicate_group.invites.where(invitee_id: current_user.id).pending
      pagy, invites = pagy invites.ransack(params[:search]).result.latest_first
      invites = SyndicateMemberApplicationSerializer.new(invites).serializable_hash[:data].map {|d| d[:attributes]}

      success('success',
        {
          records: invites,
          pagy: pagy
        }
      )
    end

    def invites
      invites = current_user.syndicate_group.invites.where(user_id: current_user.id).pending
      pagy, invites = pagy invites.ransack(params[:search]).result.latest_first
      invites = SyndicateMemberInviteSerializer.new(invites).serializable_hash[:data].map {|d| d[:attributes]}

      success('success',
        {
          records: invites,
          pagy: pagy
        }
      )
    end

    def accept_invite
      @member = @invite.eventable.syndicate_members.build(member_params)
      Invite.transaction do
        @member.role = Role.syndicate_lp
        @member.save!
        @invite.update!(status: Invite::statuses[:accepted])
      end
      success(I18n.t("syndicate_member.added"))
    rescue StandardError => error
      errors = @invite.errors.full_messages.to_sentence if @invite.errors.present?
      errors = @member.errors.full_messages.to_sentence if @member.errors.present?
      failure(errors)
    end

    def destroy
      return success(I18n.t("syndicate_member.removed_from_group")) if @syndicate_member.destroy
      
      failure(@syndicate_member.errors.full_messages.to_sentence)
    end

    def show
      success(
        'success',
        SyndicateMemberSerializer.new(@syndicate_member).serializable_hash[:data][:attributes]
      )
    end

    def update
      @syndicate_member.role = Role.find_by(title: member_role_params[:role])
      @syndicate_member.save ? success('success') :failure(@syndicate_member.errors.full_messages.to_sentence)
    end

    private

    # current user is syndicate, gp or invited investor
    def find_invite
      if current_user.syndicate?
        @invite = Invite.syndicate_membership.where(eventable: current_user.syndicate_group).find_by(id: params[:id])
      else
        @invite = Invite.syndicate_membership.where(eventable_type: 'SyndicateGroup', invitee_id: current_user.id).find_by(id: params[:id])
      end
      failure(I18n.t("invite.not_found")) if @invite.blank?
    end

    def member_params
      { member_id: (current_user.syndicate? ? @invite.user_id : @invite.invitee_id) }
    end

    def member_role_params
      params.require(:syndicate_member).permit(:role)
    end

    def find_syndicate_member
      @syndicate_member = current_user.syndicate_members.find_by(id: params[:id])
      failure(I18n.t("syndicate_member.not_found")) if @syndicate_member.blank?
    end

    def stats_by_role
      {
        all: @syndicate_members.count,
        lps: @syndicate_members.where(role_id: Role.syndicate_lp).count,
        gps: @syndicate_members.where(role_id: Role.syndicate_gp).count
      }
    end
  end
end
