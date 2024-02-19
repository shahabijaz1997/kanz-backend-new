# frozen_string_literal: true

class FundRaiserProfile < ApplicationRecord
  include ProfileState

  attr_accessor :industry_ids

  belongs_to :fund_raiser
  belongs_to :nationality, class_name: 'Country', optional: true
  belongs_to :residence, class_name: 'Country', optional: true
  has_one :attachment, as: :parent, dependent: :destroy
  has_many :profiles_industries, as: :profile, dependent: :destroy
  has_many :industries, through: :profiles_industries

  validates :company_name, :legal_name, presence: true
  validates :total_capital_raised, :current_round_capital_target,
            :ceo_name, :ceo_email, :currency, presence: true, if: :second_step?

  after_save :update_profile_industries

  accepts_nested_attributes_for :fund_raiser, update_only: true

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

  def logo
    attachment&.url
  end

  private

  def second_step?
    step == 2
  end

  def update_profile_industries
    return if industry_ids.blank?

    profiles_industries&.destroy_all
    industry_ids.each do |industry_id|
      profiles_industries.create(industry_id:)
    end
  end
end
