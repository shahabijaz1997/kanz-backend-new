# frozen_string_literal: true

# Startups apis
module V1
  class SyndicateMembersController < ApiController
    before_action :find_syndicate, only: %i[create destroy]
    before_action :find_syndicate_member

    def index
      SyndicateMemberSerializer.new(current_user.syndicate_members).serializable_hash[:data][:attributes]
    end

    def create
      member = @syndicate.build(membership_params)
      member.save ? success('successfully added') : failure(member.errors.full_messages.to_sentence)
    end

    def destroy
      return success('successfully removed from group') if @syndicate_member.destroy
      
      failure(@syndicate_member.errors.full_messages.to_sentence)
    end

    private

    def membership_params
      params.require(:syndicate_members).permit(:member_id, :member_type, :connection)
    end

    def find_syndicate
      @syndicate = Syndicate.find_by(params[:syndicate_id])

      failure('Syndicate not found') if @syndicate.blank?
    end

    def find_syndicate_member
      @syndicate_member = @syndicate.syndicate_members.find_by(params[:id])

      failure('Syndicate member not found') if @syndicate_member.blank?
    end
  end
end
