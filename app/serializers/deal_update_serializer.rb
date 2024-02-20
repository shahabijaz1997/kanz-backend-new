# frozen_string_literal: true

# Deal json serializer
class DealUpdateSerializer
  include JSONAPI::Serializer

  attributes :id, :description

  attribute :title do |deal_update|
    "#{deal_update.deal.title} - #{deal_update.added_by.company_name}"
  end

  attribute :logo do |deal_update|
    deal_update.added_by.profile.logo
  end

  attribute :attachment do |deal_update|
    deal_update.report_url
  end

  attribute :status do |deal_update|
    deal_update.humanized_enum(deal_update.status)
  end

  attribute :added_by do |deal_update|
    deal_update.added_by.name
  end

  attribute :created_at do |deal_update|
    DateTime.parse(deal_update.created_at.to_s).strftime('%d/%m/%Y %I:%M:%S %p')
  end
end
