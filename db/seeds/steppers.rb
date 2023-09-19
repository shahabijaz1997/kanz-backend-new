startup_steps = [
  {
    title: 'stage',
    index: 0,
    stepper_type: STEPPERS[:startup_deal],
    sections_attributes: [
      {
        index: 0,
        title: 'Stage',
        questions_attributes: [
          {
            index: 0,
            step: 1,
            required: true,
            statement: 'What round is this?',
            statement_ar: '',
            category: 'Stage',
            category_ar: '',
            title: "Chose a stage and we'll help you create round quickly.",
            title_ar: '',
            question_type: Question.question_types['multiple_choice'],
            description: '',
            description_ar: '',
            kind: QUESTION_KIND[:startup_deal],
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
        questions_attributes: [
          {
            index: 0,
            step: 2,
            required: true,
            statement: 'Istrument Type',
            statement_ar: '',
            category: 'Istrument Type',
            category_ar: '',
            title: '',
            title_ar: '',
            question_type: Question.question_types['multiple_choice'],
            description: '',
            description_ar: '',
            kind: QUESTION_KIND[:startup_deal],
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
            step: 2,
            required: true,
            statement: 'SAFE Type',
            statement_ar: '',
            category: '',
            category_ar: '',
            title: '',
            title_ar: '',
            question_type: Question.question_types['multiple_choice'],
            description: '',
            description_ar: '',
            kind: QUESTION_KIND[:startup_deal],
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
            index: 2,
            step: 2,
            required: true,
            statement: 'Equity Type',
            statement_ar: '',
            category: '',
            category_ar: '',
            title: '',
            title_ar: '',
            question_type: Question.question_types['multiple_choice'],
            description: '',
            description_ar: '',
            kind: QUESTION_KIND[:startup_deal],
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
        questions_attributes: [
          {
            index: 0,
            step: 3,
            required: true,
            statement: 'Deal Target',
            statement_ar: '',
            category: 'Round Size',
            category_ar: '',
            title: '',
            title_ar: '',
            question_type: Question.question_types['number_input'],
            description: '',
            description_ar: '',
            suggestions: { type: 'number', value: [500_000, 1_000_000, 2_000_000, 3_000_000] },
            kind: QUESTION_KIND[:startup_deal]
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
        questions_attributes: [
          {
            index: 0,
            step: 4,
            required: true,
            statement: 'Valuation',
            statement_ar: '',
            category: 'Valuation',
            category_ar: '',
            title: '',
            title_ar: '',
            question_type: Question.question_types['number_input'],
            description: '',
            description_ar: '',
            kind: QUESTION_KIND[:startup_deal]
          }, {
            index: 1,
            step: 4,
            required: true,
            statement: 'Type',
            statement_ar: '',
            category: '',
            category_ar: '',
            title: '',
            title_ar: '',
            question_type: Question.question_types['dropdown'],
            description: '',
            description_ar: '',
            kind: QUESTION_KIND[:startup_deal],
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
        description: 'Upload the necessary documents'
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
        title: 'Terms'
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
