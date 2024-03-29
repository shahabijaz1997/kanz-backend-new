# frozen_string_literal: true

PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x

PERSONAS = %w[Investor Syndicate FundRaiser].freeze

ADMIN_ROLES = {
  'Admin': 'admin',
  'Super Admin': 'super_admin',
  'Customer Support Rep': 'customer_support_rep',
  'Compliance Officer': 'compliance_officer'
}.freeze

ROLES = {
  'Individual Investor' => 0,
  'Investment Firm' => 1,
  'Syndicate' => 2,
  'FundRaiser' => 3
}.freeze

STATUSES = {
  opened: 0,
  submitted: 1,
  reopened: 2,
  verified: 3,
  rejected: 4,
  approved: 5
}.freeze

QUESTION_KIND = {
  investment_philosophy: 0,
  individual_accredition: 1,
  firm_accredition: 2,
  startup_deal: 3,
  property_deal: 4
}.freeze

ROUTES = {
  admin: [
    {
      name: "Manage Admins",
      path: "admin_users",
      icon: "fa fa-users-gear"
    }
  ],
  customer_user: [
    {
      name: "Investors",
      path: "investors",
      icon: "fa fa-money-bill-trend-up",
      sub_routes: [
        {
          name: "Individuals",
          path: "individuals"
        },
        {
          name: "Firms",
          path: "firms"
        }
      ]
    },
    {
      name: "Fund Raisers",
      path: "fund_raisers",
      icon: "fa fa-city"
    },
    {
      name: "Syndicates",
      path: "syndicates",
      icon: "fa fa-sitemap"
    },
    {
      name: "Deals",
      path: "deals",
      icon: "fa fa-briefcase",
      sub_routes: [
        {
          name: "Startup",
          path: "start_up"
        },
        {
          name: "Property",
          path: "property"
        }
      ]
    }
  ]
}.freeze

MAX_STEPS = {
  investor_profile: 1,
  fund_raiser_profile: 2,
  syndicate_profile: 2
}.freeze

DEAL_TYPES = {
  startup: 0,
  property: 1
}.freeze

STEPPERS = {
  startup_deal: 0,
  property_deal: 1
}.freeze

FIELD_TYPE = {
  multiple_choice: 0,
  switch: 1,
  text_box: 2,
  checkbox: 3,
  number: 4,
  dropdown: 5,
  text_field: 6,
  file: 7,
  url: 8,
  date: 9
}.freeze

VALUE_FIELDS = ['switch', 'text_box', 'number', 'text_field', 'url', 'file', 'date'].freeze
OPTION_FIELDS = ['multiple_choice', 'checkbox', 'dropdown'].freeze
INPUT_TYPES = {
  currency: 0,
  percent: 1,
  sqft: 2,
  numeric: 4
}.freeze

DEAL_STEPPER_DATE_FIELDS = ['start_at', 'end_at'].freeze

STAGES = ['Pre-seed', 'Seed / Angel', 'Series A', 'Series B', 'Series C', 'Series D', 'Mezzanine & bridge']
INSTRUMENT_TYPES = ['SAFE', 'Equity Financing']
