# frozen_string_literal: true

# Fast json serializer
class InvestorListSerializer
  include JSONAPI::Serializer

  attributes :id, :name

  attribute :profile_pic do |investor|
    investor.profile_pic
  end

  attribute :investor_type do |investor|
    I18n.locale == :en ? investor.role_title : investor.role_title_ar
  end

  attribute :accreditation do |investor|
    investor.accreditation
  end

  attribute :invested_amount do |investor|
    investor.invested_amount
  end

  attribute :no_investments do |investor|
    investor.no_investments
  end

  attribute :legal_name do |investor|
    investor.legal_name
  end
end
 