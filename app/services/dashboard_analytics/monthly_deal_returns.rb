module DashboardAnalytics
  class MonthlyDealReturns < ApplicationService
    attr_reader :user, :deal

    def initialize(user, deal)
      @user = user
      @deal = deal
    end

    def call
      monthly_returns
    end

    private

    def monthly_returns
      investment = deal.investments.find_by(user_id: user.id)
      year_months = DashboardAnalytics::YearMonthGenerator.call(investment.created_at)
      results = stack_chart_skelton

      year_months.each do |key, value|
        multiple = current_month_multiple(key)
        results[:labels] << month_name_and_year(key)
        results[:invested_amount] << investment.amount.to_f
        results[:net_value] << net_value(investment.amount.to_f, multiple)
      end
      results
    end

    def stack_chart_skelton
      {
        labels: [],
        invested_amount: [],
        net_value: []
      }
    end

    def current_month_multiple(month_and_year)
      1.0
      # month_start = beginning_of_month(month_and_year)
      # month_end = last_date_of_month(month_and_year)

      # # Deal Updates & where type is Target/price changes
      # .where("DATE_TRUNC('month', investments.created_at) > ?
      #                         OR
      #                         DATE_TRUNC('month', investments.created_at) = ?
      #                         OR
      #                         DATE_TRUNC('month', investments.created_at) < ?
      #                         OR
      #                         DATE_TRUNC('month', investments.created_at) = ?",
      #                         month_start, month_start, month_end, month_end).order(created_at: :asc)
    end

    def net_value(amount, multiple)
      amount * multiple
    end

    def beginning_of_month(month_and_year)
      year, month = month_and_year.split('/')
      DateTime.parse("#{year}-#{month.to_s.rjust(2, '0')}-01").beginning_of_month
    end

    def end_of_month(month_and_year)
      year, month = month_and_year.split('/')
      DateTime.parse("#{year}-#{month.to_s.rjust(2, '0')}-01").end_of_month
    end

    def month_name_and_year(m_y)
      year, month = m_y.split('/')
      month = Date::ABBR_MONTHNAMES[month.to_i]
      year = year.to_i % 100

      "#{month} #{year}"
    end
  end
end
