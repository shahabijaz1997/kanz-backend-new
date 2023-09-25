startup_steps = [
  {
    title: 'stage',
    index: 0,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Stage',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
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
    title: 'instrument',
    index: 1,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Instrument Type',
        fields_attributes: [
          {
            index: 0,
            is_required: true,
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
            statement: 'Deal Target',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
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
            statement: 'Valuation',
            statement_ar: '',
            label: '',
            label_ar: '',
            field_type: FIELD_TYPE[:number],
            description: '',
            description_ar: '',
          }, {
            index: 1,
            is_required: true,
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
        fields_attributes: [
          {
            index: 0,
            is_required: true,
            statement: 'Valuation Cap',
            statement_ar: '',
            label: 'Description related valuation cap',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 1,
            is_required: false,
            statement: 'Valuation Cap',
            statement_ar: '',
            field_type: FIELD_TYPE[:number]
          }, {
            index: 2,
            is_required: true,
            statement: 'Discount',
            statement_ar: '',
            label: 'Description related discount',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 3,
            is_required: false,
            statement: 'Discount',
            statement_ar: '',
            field_type: FIELD_TYPE[:number]
          }, {
            index: 4,
            is_required: true,
            statement: 'MFN Only',
            statement_ar: '',
            label: 'Description related MFN',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 5,
            is_required: false,
            statement: 'MFN',
            statement_ar: '',
            field_type: FIELD_TYPE[:number]
          }, {
            index: 6,
            is_required: true,
            statement: 'Minimum Investment Size',
            statement_ar: '',
            label: 'Description related investment',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 7,
            is_required: false,
            statement: 'Minimum Investment',
            statement_ar: '',
            field_type: FIELD_TYPE[:number]
          },          {
            index: 8,
            is_required: true,
            statement: 'Pro Rata',
            statement_ar: '',
            label: 'Description related Pro Rata',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 9,
            is_required: false,
            statement: 'Pro Rata',
            statement_ar: '',
            field_type: FIELD_TYPE[:text_field]
          },          {
            index: 10,
            is_required: true,
            statement: 'Additional Terms',
            statement_ar: '',
            label: 'Description related additional terms',
            label_ar: '',
            field_type: FIELD_TYPE[:switch]
          }, {
            index: 11,
            is_required: false,
            statement: 'Additional Terms',
            statement_ar: '',
            field_type: FIELD_TYPE[:text_box]
          },
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

startup_steps.each do |step|
  record = Stepper.find_or_initialize_by(title: step[:title])
  if record.update(step)
    Rails.logger.debug 'Successfully added step'
  else
    Rails.logger.debug record.errors.full_messages
  end
end
