# frozen_string_literal: true

# Fast json serializer
class InvestorInvestmentSerializer
  include JSONAPI::Serializer
  attributes :id

  attribute :investor_id do |investment|
    investment.user_id
  end

  attribute :deal_id do |investment|
    investment.deal_id
  end

  attribute :deal_title do |investment|
    investment.deal.title
  end

  attribute :deal_category do |investment|
    investment.deal.humanized_enum(investment.deal.deal_type)
  end

  attribute :deal_status do |investment|
    investment.deal.humanized_enum(investment.deal.status)
  end

  attribute :investment_date do |investment|
    DateTime.parse(investment.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :invested_amount do |investment|
    investment.amount.to_f
  end

  attribute :net_value do |investment|
    investment.net_value.to_f
  end

  attribute :multiple do |investment|
    (investment.net_value.to_f / investment.amount.to_f).round(2)
  end
end