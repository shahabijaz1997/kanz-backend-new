# frozen_string_literal: true

class Startup < User
  has_one :profile, class_name: 'StartupProfile', dependent: :destroy
end
