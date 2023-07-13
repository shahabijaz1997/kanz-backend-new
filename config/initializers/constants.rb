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
