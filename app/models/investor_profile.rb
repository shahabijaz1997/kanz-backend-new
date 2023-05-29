# frozen_string_literal: true

class InvestorProfile < ApplicationRecord
  belongs_to :investor
  belongs_to :country, foreign_key: :country_id
end
