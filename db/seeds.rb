# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# file_names = ['admin_roles', 'countries', 'industries', 'regions', 'role_vise_attachments',
#               'startup_stepper', 'property_stepper', 'dependency_tree']

# file_names = ['stepper_updates']

file_names = ['role_vise_attachments']

file_names.each do |file_name|
  load Rails.root.join('db', 'seeds', "#{file_name}.rb")
end
