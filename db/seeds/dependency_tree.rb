# field = FieldAttribute.find_by(statement: 'Istrument Type')
# value = field.options.find_by(statement: 'SAFE Round').id
# value2 = field.options.find_by(statement: 'Equity').id
# dependent_field = FieldAttribute.find_by(statement: 'SAFE Type')
# dependent_field2 = FieldAttribute.find_by(statement: 'Equity Type')
# dependent_step = Stepper.find_by(title: 'valuation', stepper_type: STEPPERS[:startup_deal])

# dependencies = [
#   {
#     dependable: field,
#     condition: DependencyTree.conditions[:equals],
#     value: value,
#     dependent: dependent_field,
#     operation: DependencyTree.operations[:show]
#   },
#   {
#     dependable: field,
#     condition: DependencyTree.conditions[:equals],
#     value: value,
#     dependent: dependent_field2,
#     operation: DependencyTree.operations[:hide]
#   },
#   {
#     dependable: field,
#     condition: DependencyTree.conditions[:equals],
#     value: value,
#     dependent: dependent_step,
#     operation: DependencyTree.operations[:hide]
#   },
#   {
#     dependable: field,
#     condition: DependencyTree.conditions[:equals],
#     value: value2,
#     dependent: dependent_field,
#     operation: DependencyTree.operations[:hide]
#   },
#   {
#     dependable: field,
#     condition: DependencyTree.conditions[:equals],
#     value: value2,
#     dependent: dependent_field2,
#     operation: DependencyTree.operations[:show]
#   },
#   {
#     dependable: field,
#     condition: DependencyTree.conditions[:equals],
#     value: value2,
#     dependent: dependent_step,
#     operation: DependencyTree.operations[:show]
#   }
# ]

# dependencies.each do |dependency|
#   if DependencyTree.create!(dependency)
#     puts 'Successfully added dependency'
#   else
#     puts record.errors.full_messages
#   end
# end
