# frozen_string_literal: true

class StartupProfile < ApplicationRecord
  include ProfileState

  attr_accessor :industry_ids

  belongs_to :startup
  belongs_to :country
  has_one :attachment, as: :parent, dependent: :destroy
  has_many :profiles_industries, as: :profile, dependent: :destroy
  has_many :industries, through: :profiles_industries

  validates :company_name, :legal_name, presence: true
  validates :total_capital_raised, :current_round_capital_target,
            :ceo_name, :ceo_email, :currency, presence: true, if: :second_step?

  after_save :update_profile_industries

  def total_capital_raised_with_currency
    "#{total_capital_raised.to_i} #{currency}" if total_capital_raised.present?
  end

  def current_round_capital_target_with_currency
    "#{current_round_capital_target.to_i} #{currency}" if current_round_capital_target.present?
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[company_name legal_name industry_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['industries']
  end

  private

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
