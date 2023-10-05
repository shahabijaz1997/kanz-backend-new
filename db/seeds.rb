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


FieldAttribute.find_by(statement:  'External Link').update(field_mapping: 'external_links_attributes.url')
FieldAttribute.find_by(statement:  'Property Video').update(permitted_types: ['video'])
FieldAttribute.find_by(statement:  'Country').update(
  {
    index: 0,
    is_required: true,
    field_mapping: 'property_detail_attributes.country_id',
    statement: 'Country',
    statement_ar: '',
    label: "",
    label_ar: '',
    field_type: FIELD_TYPE[:dropdown],
    description: '',
    description_ar: '',
    options_attributes: [
      {
        index: 0,
        statement: 'Bahrain',
        statement_ar: "البحرين"
      },
      {
        index: 1,
        statement: 'Kuwait',
        statement_ar: "الكويت"
      },
      {
        index: 2,
        statement: 'Qatar',
        statement_ar: "دولة قطر"
      },
      {
        index: 3,
        statement: 'Oman',
        statement_ar: "سلطنة عمان"
      },
      {
        index: 4,
        statement: 'Saudi Arabia',
        statement_ar: "المملكة العربية السعودية"
      },
      {
        index: 5,
        statement: 'United Arab Emirate',
        statement_ar: "الإمارات العربية المتحدة"
      }
    ]
  }
)