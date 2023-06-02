# frozen_string_literal: true

class StartupProfile < ApplicationRecord
  belongs_to :startup
  belongs_to :country

  validates_presence_of :company_name, :legal_name, :total_capital_raised,
                        :current_round_capital_target, :ceo_name, :ceo_email,
                        :country_id
end
