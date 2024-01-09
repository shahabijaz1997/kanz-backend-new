# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  include ProfileState

  attr_accessor :industry_ids, :region_ids

  belongs_to :syndicate
  has_one :attachment, as: :parent, dependent: :destroy
  has_many :profiles_industries, as: :profile, dependent: :destroy
  has_many :industries, through: :profiles_industries
  has_many :profiles_regions, as: :profile, dependent: :destroy
  has_many :regions, through: :profiles_regions

  validates :profile_link, :dealflow, presence: true
  validates :raised_amount, :no_times_raised, presence: true, if: :raised_before?
  validates :name, :tagline, :logo, presence: true, if: :second_step?

  after_save :update_profile_industries, :update_profile_regions
  after_create :create_group

  def self.ransackable_attributes(_auth_object = nil)
    %w[region_id industry_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[industries regions]
  end

  private

  def raised_before?
    have_you_ever_raised
  end

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

  def update_profile_regions
    return if region_ids.blank?

    profiles_regions&.destroy_all
    region_ids.each do |region_id|
      profiles_regions.create(region_id:)
    end
  end

  def create_group
    SyndicateGroup.create!(title: name, syndicate_id: syndicate_id)
  end
end
