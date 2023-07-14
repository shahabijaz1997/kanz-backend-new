# frozen_string_literal: true

# Fast json serializer
class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :email, :type, :status, :language, :profile_states

  attribute :role do |user|
    user.user_role&.title
  end
end
