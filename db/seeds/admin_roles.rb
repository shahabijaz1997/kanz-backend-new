# frozen_string_literal: true

admin_roles = ['Admin', 'Super Admin', 'Customer Support Rep', 'Compliance Officer']

admin_roles.each do |admin_role|
  AdminRole.find_or_create_by(title: admin_role)
end
