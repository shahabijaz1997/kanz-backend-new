# frozen_string_literal: true

# Fast json serializer
class InvestorSerializer
  include JSONAPI::Serializer
  has_many :attachments

  attributes :id, :name, :email, :type, :status, :language, :profile_states

  attribute :profile do |investor|
    if investor.syndicate?
      profile = investor.profile || SyndicateProfile.new(syndicate: investor)
      SyndicateProfileSerializer.new(profile).serializable_hash[:data]&.fetch(:attributes)
    else
      profile = investor.profile || InvestorProfile.new(investor: investor)
      InvestorProfileSerializer.new(profile).serializable_hash[:data]&.fetch(:attributes)
    end
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

  attribute :invested_amount do |investor|
    investor.invested_amount
  end

  attribute :no_investments do |investor|
    investor.no_investments
  end
end
