# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :attachment_configs, dependent: :destroy
  has_many :syndicate_members, dependent: :destroy
  validates :title, presence: true
  validates :title, uniqueness: true

  class << self
    def syndicate_lp
      Role.find_by(title: 'Limited Partner')
    end

    def syndicate_gp
      Role.find_by(title: 'General Partner')
    end
  end
end
