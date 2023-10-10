# frozen_string_literal: true

PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x

PERSONAS = %w[Investor Syndicate Realtor Startup].freeze

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
      sub_routes: [{
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
      name: "Realtors",
      path: "realtors",
      icon: "fa fa-city"
    },
    {
      name: "Startups",
      path: "startups",
      icon: "fa fa-building"
    },
    {
      name: "Syndicates",
      path: "syndicates",
      icon: "fa fa-sitemap"
    }
  ]
}.freeze

MAX_STEPS = {
  investor_profile: 1,
  startup_profile: 2,
  syndicate_profile: 2,
  realtor_profile: 1
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
  url: 8
}.freeze

VALUE_FIELDS = ['switch', 'text_box', 'number', 'text_field', 'url', 'file'].freeze
OPTION_FIELDS = ['multiple_choice', 'checkbox', 'dropdown'].freeze
INPUT_TYPES = {
  currency: 0,
  percent: 1,
  sqft: 2,
  numeric: 4
}.freeze
