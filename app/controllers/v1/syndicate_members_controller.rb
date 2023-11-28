# frozen_string_literal: true

# Startups apis
module V1
  class SyndicateMembersController < ApiController
    before_action :find_syndicate, only: %i[create destroy]
    before_action :find_syndicate_member, only: %i[destroy]

    def index
      connection = params[:connection].in?(SyndicateMember::connections.keys) ? params[:connection] : SyndicateMember::connections.keys
      @syndicate_members = current_user.syndicate_members
      success(
        'success',
        { members: SyndicateMemberSerializer.new(
                    @syndicate_members.filter_by_connection(connection)
                   ).serializable_hash[:data].map {|d| d[:attributes]}
                  }.merge(states: states_by_connection)
      )
    end

    def create
      member = @syndicate.syndicate_members.build(membership_params)
      member.save ? success('successfully added') : failure(member.errors.full_messages.to_sentence)
    end

    def destroy
      return success('successfully removed from group') if @syndicate_member.destroy
      
      failure(@syndicate_member.errors.full_messages.to_sentence)
    end

    private

    def membership_params
      params.require(:syndicate_member).permit(:member_id, :connection)
    end

    def find_syndicate
      @syndicate = Syndicate.find_by(id: params[:syndicate_id])

      failure('Syndicate not found') if @syndicate.blank?
    end

    def find_syndicate_member
      @syndicate_member = @syndicate.syndicate_members.find_by(id: params[:id])

      failure('Syndicate member not found') if @syndicate_member.blank?
    end

    def states_by_connection
      {
        all: @syndicate_members.count,
        added: @syndicate_members.added.count,
        follower: @syndicate_members.follower.count
      }
    end
  end
end
