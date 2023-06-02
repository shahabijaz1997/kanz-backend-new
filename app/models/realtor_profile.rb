# frozen_string_literal: true

class RealtorProfile < ApplicationRecord
  belongs_to :realtor
  belongs_to :nationality, class_name: 'Country'
  belongs_to :residence, class_name: 'Country'

  validates_presence_of :no_of_properties
end
