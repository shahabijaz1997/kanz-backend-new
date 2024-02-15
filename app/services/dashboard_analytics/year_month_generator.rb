module DashboardAnalytics
  class YearMonthGenerator < ApplicationService
    attr_reader :start_date

    def initialize(start_date)
      @start_date = start_date
    end

    def call
      year_month = year_month_list(Date.current).flatten
      year_month.map {|year_month| [year_month, 0]}.to_h
    end

    private

    def year_month_list(current_date)
      year_month_list = []
      return year_month_list = months(start_date.month, current_date.month, current_date.year) if start_date.year == current_date.year

      (start_date.year..current_date.year).map do |year|
        months(start_month(year), current_month(year, current_date), year)
      end
    end

    def start_month(year)
      (year == start_date.year) ? start_date.month : 1
    end

    def current_month(year, current_date)
      (year == current_date.year) ? current_date.month : 12
    end

    def months(start_month, current_month, year)
      (start_month..current_month).map { |month| "#{year}/#{month}" }
    end

  end
end
