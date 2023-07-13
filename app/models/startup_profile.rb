# frozen_string_literal: true

class StartupProfile < ApplicationRecord
  attr_accessor :step, :industry_ids

  belongs_to :startup
  belongs_to :country
  has_one :attachment, as: :parent, dependent: :destroy
  has_many :profiles_industries, as: :profile, dependent: :destroy
  has_many :industries, through: :profiles_industries

  validates :company_name, :legal_name, presence: true
  validates :total_capital_raised, :current_round_capital_target,
            :ceo_name, :ceo_email, :currency, presence: true, if: :second_step?

  after_save :update_profile_state
  after_save :update_profile_industries

  private

  def update_profile_state
    profile_states = startup.profile_states
    profile_states[:profile_completed] = (step == 2)
    profile_states[:profile_current_step] = step
    startup.update(profile_states: profile_states)
  end

  def second_step?
    step == 2
  end

  def update_profile_industries
    return if industry_ids.blank?

    profiles_industries&.destroy_all
    industry_ids.each do |industry_id|
      profiles_industries.create(industry_id: industry_id)
    end
  end
end
