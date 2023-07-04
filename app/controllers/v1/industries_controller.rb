# frozen_string_literal: true

module V1
  class IndustriesController < ApplicationController
    def index
      success(
        I18n.t('general.success'),
        IndustrySerializer.new(Industry.all).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end
  end
end
