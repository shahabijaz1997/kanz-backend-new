# frozen_string_literal: true

class ProfilesIndustry < ApplicationRecord
  belongs_to :industry
  belongs_to :profile, polymorphic: true
end
