# frozen_string_literal: true

# Fast json serializer
class InvestmentSerializer
  include JSONAPI::Serializer

  attributes :id, :amount

  attribute :status do |investment|
    investment.humanized_enum(investment.status)
  end

  attribute :date do |investment|
    Date.parse(investment.created_at.to_s).strftime('%d/%m/%Y')
  end

  attribute :investor_name do |investment|
    investment.user.name
  end

  attribute :investor_id do |investment|
    investment.user.id
  end

  attribute :deal_id do |investment|
    investment.deal.id
  end
end
