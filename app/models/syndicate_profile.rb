# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  belongs_to :syndicate
  has_one :attachment, as: :parent, dependent: :destroy
end
