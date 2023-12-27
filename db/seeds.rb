# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# 

file_names = [
  'user_roles', 'admin_roles', 'countries', 'industries', 'regions',
  'user_attachments_config', 'questions' , 'deal_stepper', 'dependency_tree'
]

file_names.each do |file_name|
  load Rails.root.join('db', 'seeds', "#{file_name}.rb")
end
