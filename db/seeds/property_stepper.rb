steps = [
  {
    title: 'Details',
    index: 0,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Title',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'title',
            statement: 'Title',
            statement_ar: '',
            label: "Add Title.",
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          }
        ]
      },
      {
        index: 1,
        title: 'Location',
        fields_attributes: [
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
          },
          {
            index: 1,
            is_required: true,
            field_mapping: 'property_detail_attributes.state',
            statement: 'State',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          },{
            index: 2,
            is_required: true,
            field_mapping: 'property_detail_attributes.city',
            statement: 'City',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          },{
            index: 3,
            is_required: true,
            field_mapping: 'property_detail_attributes.area',
            statement: 'Area',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          },{
            index: 4,
            is_required: true,
            field_mapping: 'property_detail_attributes.building_name',
            statement: 'Building Name',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          },
          {
            index: 5,
            is_required: true,
            field_mapping: 'property_detail_attributes.street_address',
            statement: 'Street Address',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          }
        ]
      },
      {
        index: 2,
        title: 'Size',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'property_detail_attributes.size',
            statement: 'Size',
            statement_ar: '',
            label: "500 sqft",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:sqft],
            description: '',
            description_ar: ''
          }
        ]
      },
      {
        index: 3,
        title: 'Features',
        fields_attributes: [
          {
            index: 0,
            is_required: false,
            field_mapping: 'property_detail_attributes.has_bedrooms',
            statement: 'Bedrooms',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:switch],
            description: '',
            description_ar: ''
          },
          {
            index: 1,
            is_required: false,
            field_mapping: 'property_detail_attributes.no_bedrooms',
            statement: 'Bedrooms',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:numeric],
            description: '',
            description_ar: ''
          },{
            index: 2,
            is_required: false,
            field_mapping: 'property_detail_attributes.has_kitchen',
            statement: 'Kitchen',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:switch],
            description: '',
            description_ar: ''
          },{
            index: 3,
            is_required: false,
            field_mapping: 'property_detail_attributes.no_kitchen',
            statement: 'Kitchen',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:numeric],
            description: '',
            description_ar: ''
          },{
            index: 4,
            is_required: false,
            field_mapping: 'property_detail_attributes.has_washroom',
            statement: 'Washrooms',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:switch],
            description: '',
            description_ar: ''
          },
          {
            index: 5,
            is_required: false,
            field_mapping: 'property_detail_attributes.no_washrooms',
            statement: 'Washrooms',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:numeric],
            description: '',
            description_ar: ''
          },{
            index: 6,
            is_required: false,
            field_mapping: 'property_detail_attributes.has_parking',
            statement: 'Parking',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:switch],
            description: '',
            description_ar: ''
          },
          {
            index: 7,
            is_required: false,
            field_mapping: 'property_detail_attributes.parking_capacity',
            statement: 'Parking',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:numeric],
            description: '',
            description_ar: ''
          },{
            index: 8,
            is_required: false,
            field_mapping: 'property_detail_attributes.has_swimming_pool',
            statement: 'Swimming Pool',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:switch],
            description: '',
            description_ar: ''
          },
          {
            index: 9,
            is_required: false,
            field_mapping: 'property_detail_attributes.swimming_pool_type',
            statement: 'Swimming Pool',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:dropdown],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 0,
                statement: 'Shared',
                statement_ar: '',
                is_range: false
              },
              {
                index: 1,
                statement: 'Private',
                statement_ar: '',
                is_range: false
              }
            ]
          },{
            index: 10,
            is_required: false,
            field_mapping: 'property_detail_attributes.is_rental',
            statement: 'Property on a rent?',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:switch],
            description: '',
            description_ar: ''
          },
          {
            index: 11,
            is_required: false,
            field_mapping: 'property_detail_attributes.rental_period',
            statement: 'duration',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:dropdown],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 0,
                statement: 'Monthly'
              },
              {
                index: 1,
                statement: 'Yearly'
              }
            ]
          },
          {
            index: 12,
            is_required: false,
            field_mapping: 'property_detail_attributes.rental_amount',
            statement: 'rent',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:currency],
            description: '',
            description_ar: ''
          }
        ]
      },{
        index: 13,
        title: 'Property Description',
        fields_attributes: [
          {
            index: 0,
            is_required: false,
            field_mapping: 'description',
            statement: 'Property Description',
            statement_ar: '',
            label: "Brief Description of the property",
            label_ar: '',
            field_type: FIELD_TYPE[:text_box],
            description: '',
            description_ar: ''
          }
        ]
      }
    ]
  },
  {
    title: 'Unique Selling Points',
    index: 1,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Unique Selling Points',
        is_multiple: true,
        add_more_label: '+ Add new point',
        add_more_label_ar: '' ,
        display_card: true,
        fields_attributes: [
          {
            index: 0,
            is_required: false,
            field_mapping: 'features_attributes.title',
            statement: 'Title',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:text_field],
            description: '',
            description_ar: ''
          }, {
            index: 1,
            is_required: false,
            field_mapping: 'features_attributes.description',
            statement: 'Description',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:text_box],
            description: '',
            description_ar: ''
          }
        ]
      }
    ]
  },
  {
    title: 'Attachments',
    index: 2,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Add Attachments',
        description: 'Upload the necessary documents.',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            statement: 'Property Images',
            statement_ar: '',
            label: 'Upload a image of your property',
            label_ar: '',
            description: '',
            description_ar: '',
            field_type: FIELD_TYPE[:file],
            permitted_types: ['png','jpeg'],
            size_constraints: { unit: 'mb', limit: 10 }
          },
          {
            index: 0,
            is_required: true,
            statement: 'Property Video',
            statement_ar: '',
            label: 'Upload a video of your property',
            label_ar: '',
            description: '',
            description_ar: '',
            field_type: FIELD_TYPE[:file],
            permitted_types: ['video'],
            size_constraints: { unit: 'mb', limit: 10 }
          }
        ]
      },{
        index: 1,
        title: 'Add Links',
        description: 'Upload the necessary documents.',
        is_multiple: true,
        add_more_label: '+ Add new link',
        add_more_label_ar: '',
        fields_attributes: [
          {
            index: 0,
            is_required: false,
            field_mapping: 'external_links_attributes.url',
            statement: 'External Link',
            statement_ar: '',
            label: 'www.example.com',
            label_ar: '',
            field_type: FIELD_TYPE[:url],
            description: '',
            description_ar: ''
          }
        ]
      }
    ]
  },
  {
    title: 'Selling Price',
    index: 3,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Selling Price',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'target',
            statement: 'Price',
            statement_ar: '',
            label: '$ 0.00',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:currency],
            description: '',
            description_ar: '',
            suggestions: [500000, 1000000, 2000000, 3000000]
          }
        ]
      }
    ]
  },
  {
    title: 'Expected Return',
    index: 4,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Expected Return',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'property_detail_attributes.dividend_yeild',
            statement: 'Expected Dividend Yeild',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:percent],
            suggestions: [2.5, 5.5, 8.5, 10]
          },{
            index: 1,
            is_required: true,
            field_mapping: 'property_detail_attributes.yearly_appreciation',
            statement: 'Expected Annaul Appreciation',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:percent],
            suggestions: [2.5, 5.5, 8.5, 10]
          }
        ]
      }
    ]
  },
  {
    title: 'terms',
    index: 5,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Terms',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'agreed_with_kanz_terms',
            statement: 'Agree all terms',
            statement_ar: '',
            description: '<span style="font-weight: bold; font-size: 24px;">Terms and Conditions</span><p><span style="font-weight: bold;">Acceptance of Terms&nbsp;</span></p><ul><li>Welcome to [Your Fundraising App Name] ("the App").&nbsp;</li><li>By accessing or using this App, you agree to comply with and be bound by these Terms and Conditions.&nbsp;</li><li>If you do not agree to these Terms and Conditions, please do not use the App.&nbsp;</li></ul><p><span style="font-weight: bold;">Use of the App</span></p><ul><li>&nbsp;You must be at least 18 years old to use this App.&nbsp;</li><li>You are responsible for maintaining the confidentiality of your account and password.&nbsp;</li><li>You agree not to use the App for any illegal or unauthorized purpose.&nbsp;</li><li>You may not use the App to harass, abuse, or harm others.&nbsp;</li><li>You may not transmit any worms or viruses or any code of a destructive nature.&nbsp;</li></ul><p><span style="font-weight: bold;">Fundraising Guidelines</span></p><ul><li>&nbsp;[Your Fundraising App Name] provides a platform for individuals and organizations to create and manage fundraising campaigns.&nbsp;</li><li>Users are solely responsible for the content, accuracy, and legality of their fundraising campaigns.&nbsp;</li><li>You may not use the App for fraudulent or misleading purposes.&nbsp;</li><li>We reserve the right to remove or suspend any fundraising campaign that violates these Terms and Conditions.&nbsp;</li></ul><p><span style="font-weight: bold;">Financial Transactions</span></p><ul><li>Donations made through the App are non-refundable.&nbsp;</li><li>[Your Fundraising App Name] may charge a processing fee for each donation made.&nbsp;</li><li>We do not store credit card information on our servers.</li></ul>',
            label: 'Description about terms',
            label_ar: '',
            field_type: FIELD_TYPE[:checkbox]
          }
        ]
      }
    ]
  },
  {
    title: 'review',
    index: 6,
    stepper_type: STEPPERS[:property_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Review'
      }
    ]
  }
]

steps.each do |step|
  record = Stepper.find_or_initialize_by(stepper_type: step[:stepper_type], title: step[:title])
  next if record.persisted?
  if record.update(step)
    Rails.logger.debug 'Successfully added step'
  else
    puts record.errors.full_messages
    Rails.logger.debug record.errors.full_messages
  end
end

statements = ['Swimming Pool', 'Parking','Washrooms', 'Kitchen','Bedrooms']
FieldAttribute.where(statement: statements).where.not(field_type: FIELD_TYPE[:switch]).each do |f|
  dependent_id = FieldAttribute.find_by(statement: f.statement, field_type: FIELD_TYPE[:switch])&.id
  f.update!(dependent_id: dependent_id)
end

statements = ['duration', 'rent']
FieldAttribute.where(statement: statements).where.not(field_type: FIELD_TYPE[:switch]).each do |f|
  dependent_id = FieldAttribute.find_by(statement: 'Property on a rent?', field_type: FIELD_TYPE[:switch])&.id
  f.update!(dependent_id: dependent_id)
end

field = FieldAttribute.find_by(field_mapping: 'features_attributes.title')
FieldAttribute.find_by(field_mapping: 'features_attributes.description').update(dependent_id: field.id)
field.update(dependent_id: field.id)

field_mappings = ['property_detail_attributes.no_bedrooms', 'property_detail_attributes.no_kitchen', 'property_detail_attributes.parking_capacity', 'property_detail_attributes.no_washrooms']
field_mappings.each do |mapping|
  FieldAttribute.find_by(field_mapping: mapping).update(input_type: INPUT_TYPES[:numeric])
end

field_mappings = ['property_detail_attributes.rental_amount', 'target']
field_mappings.each do |mapping|
  FieldAttribute.find_by(field_mapping: mapping).update(input_type: INPUT_TYPES[:currency])
end

field_mappings = ['property_detail_attributes.yearly_appreciation', 'property_detail_attributes.dividend_yeild']
field_mappings.each do |mapping|
  FieldAttribute.find_by(field_mapping: mapping).update(input_type: INPUT_TYPES[:percent])
end

field_mappings = ['property_detail_attributes.size']
field_mappings.each do |mapping|
  FieldAttribute.find_by(field_mapping: mapping).update(input_type: INPUT_TYPES[:sqft])
end

FieldAttribute.find_by(field_mapping: 'property_detail_attributes.size').update(field_type: FIELD_TYPE[:number])

attachments = [
  { statement: "Property Title", label: "A legal document establishing property ownership.", description: "To verify ownership and ensure no disputes.", is_required: true },
  { statement: "Property Appraisal Report", label: "Professional Valuation of  the property.", description: "To assess the property's market  value.", is_required: true },
  { statement: "Current Lease Agreements",  label: "Copies of any active lease  agreements.", description: "To assess current revenue  streams.", is_required: false },
  { statement: "Local Area Report", label: "Analysis of the local area  and market trends.", description: "To provide contextual background.", is_required: false },
  { statement: "Maintenance and Upkeep", label: "Documented history of  maintenance.", description: "To understand the property's condition and future costs.", is_required: false },
  { statement: "Financial Projections", label: "Forward-looking financial estimates.", description: "To assess economic viability.", is_required: true },
  { statement: "Independent Property Report", label: "A third-party report detailing property condition.", description: "To provide an unbiased evaluation of the property's condition.", is_required: false },
  { statement: "Term Sheet", label: "Basic terms and conditions  for investment.", description: "To clarify terms and expectations.", is_required: false },
  { statement: "Independent Area Report", label: "Comprehensive analysis of  property's location.", description: "To provide contextual information.", is_required: false },
  { statement: "Lead Syndicate Profile", label: "Information about the lead  syndicate.", description: "To establish credibility.", is_required: false },
  { statement: "5-Year Proforma", label: "Financial statement projecting metrics for the  next 5 years.", description: "To provide a long-term view.", is_required: false }
]

stepper = Stepper.find_by(title: 'Attachments', stepper_type: STEPPERS[:property_deal])
section = stepper.sections.find_by(title: 'Add Attachments')
fids = section.fields_sections.pluck(:field_id)
section.fields_sections.delete_all
FieldAttribute.where(id: fids).delete_all

attachments.each_with_index do |attachment, index|
  field = FieldAttribute.create(
    index: index,
    is_required: false,
    statement: attachment[:statement],
    label: attachment[:label],
    description: attachment[:description],
    field_type: FIELD_TYPE[:file],
    permitted_types: ['pdf'],
    size_constraints: { unit: 'mb', limit: 10 }
  )
  section.fields << field
end
