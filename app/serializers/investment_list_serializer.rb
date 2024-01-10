# frozen_string_literal: true

# Fast json serializer
class InvestmentListSerializer
  include JSONAPI::Serializer

  attribute :investor_id do |investment|
    investment.user.id
  end

  attribute :name do |investment|
    investment.user.name
  end

  attribute :deal_title do |investment|
    investment.deal.title
  end

  attribute :investment_status do |investment|
    investment.humanized_enum(investment.status)
  end

  attribute :invested_amount do |investment|
    investment.amount
  end

  attribute :investment_date do |investment|
    DateTime.parse(investment.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end
end
