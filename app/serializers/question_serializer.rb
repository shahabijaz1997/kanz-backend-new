# frozen_string_literal: true

# Question's json serializer
class QuestionSerializer
    include JSONAPI::Serializer
    attributes :id, :step, :index, :category, :title, :statement, :required, :question_type, :description, :options
end
