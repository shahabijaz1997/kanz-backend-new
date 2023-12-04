# frozen_string_literal: true

# Its a mixup of invites for investments and actual investment
class DealActivitySerializer
  include JSONAPI::Serializer

  attribute :activity_id do |activity|
    activity.id
  end

  attribute :status do |activity|
    activity.status
  end

  attribute :investor do |activity|
    if activity.is_a? Investment
      {
        id: activity.user_id,
        name: activity.user.name
      }
    else
      {
        id: activity.invitee_id,
        name: activity.invitee.name
      }
    end
  end

  attribute :type do |activity|
    activity.is_a?(Investment) ? 'investment' : activity.purpose
  end

  attribute :date do |activity|
    Date.parse(activity.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :amount do |activity|
    (activity.is_a? Investment) ? activity.amount : 0.00
  end
end
