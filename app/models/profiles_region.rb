# frozen_string_literal: true

class ProfilesRegion < ApplicationRecord
  belongs_to :region
  belongs_to :profile, polymorphic: true
end
