# frozen_string_literal: true

PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x
PERSONAS = %w[Investor Syndicate Realtor Startup].freeze
ROLES = {
  'Individual Investor' => 0,
  'Investment Firm' => 1,
  'Startup' => 2,
  'Syndicate' => 3,
  'Realtor' => 4
}.freeze
STATUSES = {
  pending: 0,
  inprogress: 1,
  submitted: 2,
  verified: 3,
  under_review: 4,
  approved: 5,
  rejected: 6
}.freeze

COUNTRIES = [
  { country_name: 'Bahrain',
    states: ['Manama', 'Riffa', 'Muharraq', 'Hamad Town', "A'ali", 'Isa Town', 'Sitra', 'Budaiya', 'Jidhafs',
             'Al-Malikiyah'] },
  { country_name: 'Kuwait', states: ['Capital', 'Hawalli', 'Mubarak Al-Kabeer', 'Ahmadi', 'Farwaniya', 'Jahra'] },
  { country_name: 'Qatar',
    states: ['Al Shamal', 'Al Khor', 'Al-Shahaniya', 'Umm Salal', 'Al Daayen', 'Doha (Ad Dawhah)', 'Al Rayyan',
             'Al Wakra'] },
  { country_name: 'Oman',
    states: ['Musandam', 'Al Buraimi', 'Al Batinah North', 'Al Batinah South', 'Muscat', "A'Dhahirah", "A'Dakhiliya",
             "A'Sharqiyah North", "A'Sharqiyah South", 'Al Wusta', 'Dhofar'] },
  { country_name: 'Saudi Arabia',
    states: ['Mecca', 'Riyadh', 'Eastern Region', "'Asir", 'Jazan', 'Medina', 'Al-Qassim', 'Tabuk', 'Najd', "Ha'il",
             'Najran', 'Al-Jawf', 'Al-Bahah', 'Northern Borders'] },
  { country_name: 'United Arab Emirates',
    states: ['Abu Dhabi', 'Dubai', 'Sharjah', 'Umm Al Qaiwain', 'Fujairah', 'Ajman', 'Ras Al Khaimah'] }
].freeze
