# frozen_string_literal: true

class FundingRound < ApplicationRecord
  belongs_to :deal

  # enum round: { 'Angel Round' => 0, 'Pre-seed' => 1, 'Seed' => 2, 'Series A' => 3, 'Other' => 4 }
  # enum instrument_type: { 'SAFE Round' => 0, 'Equity' => 1 }
  # enum safe_type: { 'Post-Money' => 0, 'Pre-Money' => 1 }
  # enum equity_type: { 'Preferred' => 0, 'Common' => 1 }
  # enum valuation_phase: { 'Pre-Money' => 0, 'Post-Money' => 1 }
end
