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
            field_type: FIELD_TYPE[:text_field],
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
            is_required: true,
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
            is_required: true,
            field_mapping: 'property_detail_attributes.no_bedrooms',
            statement: 'Bedrooms',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            description: '',
            description_ar: ''
          },{
            index: 2,
            is_required: true,
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
            is_required: true,
            field_mapping: 'property_detail_attributes.no_kitchen',
            statement: 'Kitchen',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            description: '',
            description_ar: ''
          },{
            index: 4,
            is_required: true,
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
            is_required: true,
            field_mapping: 'property_detail_attributes.no_washrooms',
            statement: 'Washrooms',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            description: '',
            description_ar: ''
          },{
            index: 4,
            is_required: true,
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
            index: 5,
            is_required: true,
            field_mapping: 'property_detail_attributes.parking_capacity',
            statement: 'Parking',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            description: '',
            description_ar: ''
          },{
            index: 4,
            is_required: true,
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
            index: 5,
            is_required: true,
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
            index: 4,
            is_required: true,
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
            index: 5,
            is_required: true,
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
            index: 5,
            is_required: true,
            field_mapping: 'property_detail_attributes.rental_amount',
            statement: 'rent',
            statement_ar: '',
            label: "",
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            description: '',
            description_ar: ''
          }
        ]
      },      {
        index: 4,
        title: 'Property Description',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
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
            is_required: true,
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
            is_required: true,
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
            is_required: true,
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
            suggestions: ['%2.5', '%5.5', '%8.5', '%10']
          }, {
            index: 1,
            is_required: true,
            field_mapping: 'property_detail_attributes.yearly_appreciation',
            statement: 'Expected Annula Appreciation',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            suggestions: ['%2.5', '%5.5', '%8.5', '%10']
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
            description: "",
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


statements = [
  {
    old: 'No Bedrooms',
    new: 'Bedrooms'
  },{
    old: 'No Kitchen',
    new: 'Kitchen',
  },{
    old: 'No Washrooms',
    new: 'Washrooms',
  },{
    old: 'No Parking',
    new: 'Parking',
  },{
    old: 'Swimming Pool Type',
    new: 'Swimming Pool',
  },{
    old: 'Per-month',
    new: 'duration',
  }
]

statements.each do |statement|
  FieldAttribute.find_by(statement: statement[:old]).update!(statement: statement[:new])
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
