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

  attribute :investor_type do |investor|
    investor.role 'Individual Investor' : 'Investment Firm'
  end

  attribute :role do |user|
    user.user_role&.title
  end

  attribute :role_ar do |user|
    user.user_role&.title_ar
  end

  attribute :steps_completed do |user|
    if UsersResponse.exists?(user_id: user.id)
      question_id = user.investment_philosophies.order(:created_at).last.question_id
      Question.find_by(id: question_id).step
    else
      0
    end
  end
end
