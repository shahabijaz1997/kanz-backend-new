# frozen_string_literal: true

class SyndicateProfile < ApplicationRecord
  attr_accessor :industry_ids, :region_ids

  belongs_to :syndicate
  has_one :attachment, as: :parent, dependent: :destroy

  has_many :profiles_industries, as: :profile, dependent: :destroy
  has_many :industries, through: :profiles_industries
  has_many :profiles_regions, as: :profile, dependent: :destroy
  has_many :regions, through: :profiles_regions

  after_create :update_profile_state
  after_save :update_profile_industries, :update_profile_regions

  private

  def update_profile_state
    profile_states = syndicate.profile_states
    profile_states[:profile_completed] = true
    syndicate.update(profile_states: profile_states)
  end

  def update_profile_industries
    return if industry_ids.blank?

    profiles_industries&.destroy_all
    industry_ids.each do |industry_id|
      profiles_industries.create(industry_id: industry_id)
    end
  end

  def update_profile_regions
    return if region_ids.blank?

    profiles_regions&.destroy_all
    region_ids.each do |region_id|
      profiles_regions.create(region_id: region_id)
    end
  end
end
