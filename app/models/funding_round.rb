# frozen_string_literal: true

class FundingRound < ApplicationRecord
  has_one :deal, as: :detail, dependent: :nullify
end
