steps = [
  {
    title: 'instrument',
    index: 0,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Instrument Type',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'funding_round_attributes.instrument_type',
            statement: 'Istrument Type',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:multiple_choice],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 0,
                statement: 'SAFE Round',
                statement_ar: '',
                label: 'Description related SAFE',
                label_ar: '',
                is_range: false
              },
              {
                index: 1,
                statement: 'Equity',
                statement_ar: 'Description related equity',
                label: '',
                label_ar: '',
                is_range: false
              }
            ]
          }, {
            index: 1,
            is_required: true,
            field_mapping: 'funding_round_attributes.safe_type',
            statement: 'SAFE Type',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:multiple_choice],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 1,
                statement: 'Post-Money',
                statement_ar: '',
                label: 'Description related post-money SAFE',
                label_ar: '',
                is_range: false
              },
              {
                index: 0,
                statement: 'Pre-Money',
                statement_ar: '',
                label: 'Description related pre-money SAFE',
                label_ar: '',
                is_range: false
              }
            ]
          }, {
            index: 1,
            is_required: true,
            field_mapping: 'funding_round_attributes.equity_type',
            statement: 'Equity Type',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:multiple_choice],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 0,
                statement: 'Preferred',
                statement_ar: '',
                label: 'Description related preferred shares',
                label_ar: '',
                is_range: false
              },
              {
                index: 1,
                statement: 'Common',
                statement_ar: '',
                label: 'Description related common shares',
                label_ar: '',
                is_range: false
              }
            ]
          }
        ]
      }
    ]
  },
  {
    title: 'stage',
    index: 1,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Stage',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'funding_round_attributes.round',
            statement: 'What round is this?',
            statement_ar: '',
            label: "Chose a stage and we'll help you create round quickly.",
            label_ar: '',
            field_type: FIELD_TYPE[:multiple_choice],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 0,
                statement: 'Angel Round',
                statement_ar: '',
                is_range: false
              },
              {
                index: 1,
                statement: 'Pre-seed',
                statement_ar: '',
                is_range: false
              },
              {
                index: 2,
                statement: 'Seed',
                statement_ar: '',
                is_range: false
              },
              {
                index: 3,
                statement: 'Series A',
                statement_ar: '',
                is_range: false
              },
              {
                index: 4,
                statement: 'Other',
                statement_ar: '',
                is_range: false
              }
            ]
          }
        ]
      }
    ]
  },
  {
    title: 'round size',
    index: 2,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Round Size',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'target',
            statement: 'Deal Target',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:currency],
            description: '',
            description_ar: '',
            suggestions: [500_000, 1_000_000, 2_000_000, 3_000_000]
          }
        ]
      }
    ]
  },
  {
    title: 'valuation',
    index: 3,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Valuation',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            field_mapping: 'funding_round_attributes.valuation',
            statement: 'Valuation',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:currency],
            description: '',
            description_ar: '',
          }, {
            index: 1,
            is_required: true,
            field_mapping: 'funding_round_attributes.valuation_phase',
            statement: 'Type',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:dropdown],
            description: '',
            description_ar: '',
            options_attributes: [
              {
                index: 0,
                statement: 'Pre-Money',
                statement_ar: '',
                is_range: false
              },
              {
                index: 1,
                statement: 'Post-Money',
                statement_ar: '',
                is_range: false
              }
            ]
          }
        ]
      }
    ]
  },
  {
    title: 'attachments',
    index: 4,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Add Attachments',
        description: 'Upload the necessary documents',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            statement: 'Pitch Deck',
            statement_ar: '',
            label: 'Upload PDF of your pitch deck',
            label_ar: '',
            field_type: FIELD_TYPE[:file],
            permitted_types: ['pdf'],
            size_constraints: { unit: 'mb', limit: 10 }
          }, {
            index: 1,
            is_required: true,
            statement: 'Documents',
            statement_ar: '',
            label: 'Upload PDF of your documents',
            label_ar: '',
            field_type: FIELD_TYPE[:file],
            permitted_types: ['pdf'],
            size_constraints: { unit: 'mb', limit: 10 }
          }
        ]
      }
    ]
  },
  {
    title: 'terms',
    index: 5,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Terms',
        condition: 'safe',
        fields_attributes: [
          {
            index: 0,
            is_required: false,
            field_mapping: 'terms_attributes.enabled',
            statement: 'Valuation Cap',
            statement_ar: '',
            label: 'Description related valuation cap',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 1,
            is_required: false,
            field_mapping: 'terms_attributes.custom_input',
            statement: 'Valuation Cap',
            statement_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:currency]
          }, {
            index: 2,
            is_required: false,
            field_mapping: 'terms_attributes.enabled',
            statement: 'Discount',
            statement_ar: '',
            label: 'Description related discount',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 3,
            is_required: false,
            field_mapping: 'terms_attributes.custom_input',
            statement: 'Discount',
            statement_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:percent]
          }, {
            index: 4,
            is_required: false,
            field_mapping: 'terms_attributes.enabled',
            statement: 'MFN Only',
            statement_ar: '',
            label: 'Description related MFN',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          },{
            index: 6,
            is_required: false,
            field_mapping: 'terms_attributes.enabled',
            statement: 'Minimum Check Size',
            statement_ar: '',
            label: 'Description related investment',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 7,
            is_required: false,
            field_mapping: 'terms_attributes.custom_input',
            statement: 'Minimum Check Size',
            statement_ar: '',
            field_type: FIELD_TYPE[:number],
            input_type: INPUT_TYPES[:currency]
          },          {
            index: 8,
            is_required: false,
            field_mapping: 'terms_attributes.enabled',
            statement: 'Pro Rata',
            statement_ar: '',
            label: 'Description related Pro Rata',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          },{
            index: 10,
            is_required: false,
            field_mapping: 'terms_attributes.enabled',
            statement: 'Additional Terms',
            statement_ar: '',
            label: 'Description related additional terms',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 11,
            is_required: false,
            field_mapping: 'terms_attributes.custom_input',
            statement: 'Additional Terms',
            statement_ar: '',
            field_type: FIELD_TYPE[:text_box]
          }
        ]
      }
    ]
  },
  {
    title: 'review',
    index: 6,
    stepper_type: STEPPERS[:startup_deal],
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
    Rails.logger.debug record.errors.full_messages
  end
end
FieldAttribute.where(statement: 'Minimum Investment Size').each do |f|
  f.update(statement: 'Minimum Check Size')
end

statements = ['Valuation Cap', 'Discount' ,'Minimum Check Size','Additional Terms']
FieldAttribute.where(statement: statements).where.not(field_type: FIELD_TYPE[:switch]).each do |f|
  dependent_id = FieldAttribute.find_by(statement: f.statement, field_type: FIELD_TYPE[:switch])&.id
  f.update!(dependent_id: dependent_id)
end

section = Section.create({
  index: 0,
  title: 'Terms',
  condition: 'equity',
  stepper_id: Stepper.find_by(title: 'terms')&.id
})

statements = ['Additional Terms', 'Minimum Check Size', 'Pro Rata']
section.fields << FieldAttribute.where(statement: statements)


statements = ['Valuation Cap', 'Discount' , 'MFN Only','Minimum Check Size','Pro Rata','Additional Terms']
FieldAttribute.where(statement: statements).each do |f|
  f.update(is_required: false)
end
