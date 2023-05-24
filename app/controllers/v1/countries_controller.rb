module V1
  class CountriesController < ApplicationController
    def index
      data = { countries: COUNTRIES }
      success(I18n.t('general.countries_list'), data)
    end
  end
end
