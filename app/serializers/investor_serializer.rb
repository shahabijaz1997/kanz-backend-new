# frozen_string_literal: true

# Fast json serializer
class InvestorSerializer
  include JSONAPI::Serializer
  has_many :attachments

  attributes :name, :email, :type, :status, :language, :profile_states

  attribute :profile do |investor|
    InvestorProfileSerializer.new(
      investor.profile
    ).serializable_hash[:data]&.fetch(:attributes)
  end

  attribute :role do |user|
    user.user_role&.title
  end

  attribute :role_ar do |user|
    user.user_role&.title_ar
  end

  attribute :steps_completed do |user|
    if UsersResponse.exists?(user_id: user.id)
      question_ids = user.investment_philosophies.pluck(:question_id)
      Question.where(id: question_ids).maximum(:step)
    else
      0
    end
  end
end
