field = FieldAttribute.find_by(field_mapping: "funding_round_attributes.instrument_type_id")
value = field.options.find_by(statement: 'SAFE').id
value2 = field.options.find_by(statement: 'Equity Financing').id
dependent_field = FieldAttribute.find_by(field_mapping: 'funding_round_attributes.safe_type_id')
dependent_field2 = FieldAttribute.find_by(field_mapping: 'funding_round_attributes.equity_type_id')
dependent_step = Stepper.find_by(title: 'valuation', stepper_type: STEPPERS[:startup_deal])

dependencies = [
  {
    dependable: field,
    condition: DependencyTree.conditions[:equals],
    value: value,
    dependent: dependent_field,
    operation: DependencyTree.operations[:show]
  },
  {
    dependable: field,
    condition: DependencyTree.conditions[:equals],
    value: value,
    dependent: dependent_field2,
    operation: DependencyTree.operations[:hide]
  },
  {
    dependable: field,
    condition: DependencyTree.conditions[:equals],
    value: value,
    dependent: dependent_step,
    operation: DependencyTree.operations[:hide]
  },
  {
    dependable: field,
    condition: DependencyTree.conditions[:equals],
    value: value2,
    dependent: dependent_field,
    operation: DependencyTree.operations[:hide]
  },
  {
    dependable: field,
    condition: DependencyTree.conditions[:equals],
    value: value2,
    dependent: dependent_field2,
    operation: DependencyTree.operations[:show]
  },
  {
    dependable: field,
    condition: DependencyTree.conditions[:equals],
    value: value2,
    dependent: dependent_step,
    operation: DependencyTree.operations[:show]
  }
]

dependencies.each do |dependency|
  if DependencyTree.create!(dependency)
    puts 'Successfully added dependency'
  else
    puts record.errors.full_messages
  end
end

### Set Dependent for startup deal terms step
statements = ['Valuation Cap', 'Discount' ,'Minimum Check Size','Additional Terms']
FieldAttribute.where(statement: statements).where.not(field_type: FIELD_TYPE[:switch]).each do |f|
  section_id = f.section_id
  dependent_id = FieldAttribute.find_by(statement: f.statement, field_type: FIELD_TYPE[:switch], section_id: section_id)&.id
  f.update!(dependent_id: dependent_id)
end

### Set Dependent for Property deal first step
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
