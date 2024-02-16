module DashboardAnalytics
  class MonthlyInvestment < ApplicationService
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def call
      monthly_investments(oldest_investment_date)
    end

    private

    def monthly_investments(starting_date)
      results = stack_chart_skelton
      year_month_investment = DashboardAnalytics::YearMonthGenerator.call(starting_date)

      year_month_investment.each do |key, value|
        investments = investments_till_month(key)
        result = investmen_and_return_by_deal_type(investments)
        results[:labels] << month_name_and_year(key)
        results[:property_investment] << result[:property_investment]
        results[:startup_investment] << result[:startup_investment]
        results[:property_net_value] << result[:property_net_value]
        results[:startup_net_value] << result[:startup_net_value]
      end
      results
    end

    def oldest_investment_date
      user.investments.find_by(created_at: user.investments.minimum(:created_at)).created_at
    end

    def investments_till_month(month_and_year_string)
      date = parse_date(month_and_year_string)
      user.investments.where("DATE_TRUNC('month', investments.created_at) < ?
                              OR
                              DATE_TRUNC('month', investments.created_at) = ?",
                              date, date)
    end

    def investmen_and_return_by_deal_type(investments)
      {
        property_investment: investments.by_property.sum(:amount).to_f,
        startup_investment: investments.by_startup.sum(:amount).to_f,
        property_net_value: investment_value(investments.by_property),
        startup_net_value: investment_value(investments.by_startup)
      }
    end

    def investment_value(investments)
      investments.map{ |investment| investment.amount.to_f * investment.deal.valuation_multiple }.reduce(&:+).to_f

    end

    def parse_date(month_and_year_string)
      year, month = month_and_year_string.split('/')
      "#{year}-#{month.to_s.rjust(2, '0')}-01"
    end

    def stack_chart_skelton
      {
        labels: [],
        property_investment: [],
        startup_investment: [],
        property_net_value: [],
        startup_net_value: []
      }
    end

    def month_name_and_year(m_y)
      year, month = m_y.split('/')
      month = Date::ABBR_MONTHNAMES[month.to_i]
      year = year.to_i % 100
      "#{month} #{year}"
    end
  end
end
