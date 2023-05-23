PASSWORD_REGEX = /\A(?=.{8,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[^[:alnum:]])/x
PERSONAS = ['Investor', 'Syndicate', 'Realtor', 'Startup']
ROLES = {
  'Individual Investor': 0,
  'Investment Firm': 1,
  'Startup': 2,
  'Syndicate': 3,
  'Property': 4
}
STATUSES = {
  pending: 0,
  inprogress: 1,
  submitted: 2,
  verified: 3,
  under_review: 4,
  approved: 5,
  rejected: 6
}
