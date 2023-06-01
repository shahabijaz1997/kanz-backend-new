# frozen_string_literal: true

class Realtor < User
  has_one :profile, class_name: 'RealtorProfile', dependent: :destroy
end
