module V1
  class CountriesController < ApiController
    def index
      success(
        I18n.t('general.countries_list'),
        CountrySerializer.new(Country.all).serializable_hash[:data].map { |d| d[:attributes] }
      )
    end
  end
end
