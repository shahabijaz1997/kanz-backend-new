# frozen_string_literal: true

PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x
PERSONAS = %w[Investor Syndicate Realtor Startup].freeze
ROLES = {
  'Individual Investor' => 0,
  'Investment Firm' => 1,
  'Syndicate' => 2,
  'Realtor' => 3,
  'Startup' => 4
}.freeze
STATUSES = {
  opened: 0,
  submitted: 1,
  reopened: 2,
  verified: 3,
  rejected: 4,
  approved: 5
}.freeze
