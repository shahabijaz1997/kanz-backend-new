# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Dir[Rails.root.join('db', 'seeds', '*.rb')].each do |seed|
#   Rails.logger.debug { "seeding - #{seed}. loading seeds, for real!" }
#   load seed
# end

load Dir[Rails.root.join('db', 'seeds', 'property_stepper.rb')].first
load Dir[Rails.root.join('db', 'seeds', 'startup_stepper.rb')].first
