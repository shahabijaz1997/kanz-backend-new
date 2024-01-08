# frozen_string_literal: true

class Role < ApplicationRecord
  has_many :attachment_configs, dependent: :destroy
  has_many :syndicate_members, dependent: :destroy
  validates :title, presence: true
  validates :title, uniqueness: true

  class << self
    def syndicate_lp
      Role.find_by(title: LIMITED_PARTNER)
    end

    def syndicate_gp
      Role.find_by(title: GENERAL_PARTNER)
    end

    def individual_investor
      Role.find_by(title: INDIVIDUAL_INVESTOR)
    end

    def firm_investor
      Role.find_by(title: INVESTMENT_FIRM)
    end
  end
end
