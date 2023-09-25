# frozen_string_literal: true

# Question's json serializer
class DependencyTreeSerializer
  include JSONAPI::Serializer
  attributes :condition, :value, :dependent_type, :dependent_id, :operation
end
