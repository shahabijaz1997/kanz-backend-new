# frozen_string_literal: true

module V1
  class IndustriesController < ApiController
    def index
      success(
        I18n.t('general.success'),
        IndustrySerializer.new(Industry.all).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end

    def regions
      success(
        I18n.t('general.success'),
        RegionSerializer.new(Region.all).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end
  end
end
