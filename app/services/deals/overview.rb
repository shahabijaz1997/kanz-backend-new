module Deals
  class Overview < Base
    attr_reader :deal_attribues
    def call
      @deal_attribues = super
      role_based_deal_attributes
    end

    private

    def role_based_deal_attributes
      return deal_attribues if user.fund_raiser?

      user.syndicate? ? deal_attributes_syndicate : deal_attributes_investor
    end

    def deal_attributes_syndicate
      deal_attribues.merge(docs).merge(comments).merge(invite)
    end

    def deal_attributes_investor
      deal_attribues.merge(docs)
    end

    def docs
      docs = deal.attachments.where(uploaded_by: deal.user)
      return {} if docs.blank?

      { docs: AttachmentSerializer.new(docs).serializable_hash[:data].map {|d| d[:attributes]} }
    end

    def comments
      comments = deal.comments.where('author_id=? OR recipient_id=?', user.id, user.id)
      return {} if comments.blank?

      {
        comments: CommentSerializer.new(comments).serializable_hash[:data].map {|d| d[:attributes]},
        thread_id: deal.syndicate_comment(user.id)&.id
      }
    end

    def invite
      invite = deal.invites.find_by(invitee_id: user.id)
      return {} if invite.blank?

      {
        invite: {
          id: invite.id,
          status: (invite.expired? ? 'expired' : invite.status),
          invited_by: invite.user.name
        }
      }
    end
  end
end
