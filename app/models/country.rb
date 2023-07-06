# frozen_string_literal: true

class Country < ApplicationRecord

  def self.ransackable_attributes(auth_object = nil)
    ["name"]
  end
end
