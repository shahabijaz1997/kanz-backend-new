Stepper.create({
  title: 'Deal Timeline',
  index: 5,
  stepper_type: STEPPERS[:property_deal],
  sections_attributes: [
    {
      index: 0,
      title: 'Select date',
      fields_attributes: [
        {
          index: 0,
          is_required: true,
          field_mapping: 'start_at',
          statement: 'start date',
          statement_ar: '',
          label: "",
          label_ar: '',
          field_type: FIELD_TYPE[:date],
          description: '',
          description_ar: ''
        },{
          index: 1,
          is_required: false,
          field_mapping: 'end_at',
          statement: 'end date',
          statement_ar: '',
          label: "",
          label_ar: '',
          field_type: FIELD_TYPE[:date],
          description: '',
          description_ar: ''
        }
      ]
    }
  ]
})

Stepper.where(title: ['terms', 'review']).each do |step|
  step.update(index: step.index + 1)
end

Stepper.where(stepper_type: STEPPERS[:startup_deal], title: ['attachments', 'valuation', 'round size']).each do |step|
  step.update(index: step.index + 1)
end

Stepper.create({
  title: 'Title',
  index: 2,
  stepper_type: STEPPERS[:startup_deal],
  sections_attributes: [
    {
      index: 0,
      title: 'Describe your deal',
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
        },{
          index: 1,
          is_required: false,
          field_mapping: 'description',
          statement: 'Startup description',
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
})

Stepper.create(  {
  title: 'Deal Timeline',
  index: 6,
  stepper_type: STEPPERS[:startup_deal],
  sections_attributes: [
    {
      index: 0,
      title: 'Select date',
      fields_attributes: [
        {
          index: 0,
          is_required: true,
          field_mapping: 'start_at',
          statement: 'start date',
          statement_ar: '',
          label: "",
          label_ar: '',
          field_type: FIELD_TYPE[:date],
          description: '',
          description_ar: ''
        },{
          index: 1,
          is_required: false,
          field_mapping: 'end_at',
          statement: 'end date',
          statement_ar: '',
          label: "",
          label_ar: '',
          field_type: FIELD_TYPE[:date],
          description: '',
          description_ar: ''
        }
      ]
    }
  ]
})
