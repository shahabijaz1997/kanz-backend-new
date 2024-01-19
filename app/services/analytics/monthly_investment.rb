module Analytics
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
      year_month_investment = Analytics::YearMonthGenerator.call(starting_date)

      year_month_investment.each do |key, value|
        investments = investments_till_month(key)
        year_month_investment[key] = investmen_and_return_by_deal_type(investments)
      end
      year_month_investment
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
      [
        { property_investment: investments.by_property.sum(:amount).to_f },
        { startup_investment: investments.by_startup.sum(:amount).to_f },
        { property_net_value: investments.by_property.sum(:amount).to_f },
        { startup_net_value: investments.by_startup.sum(:amount).to_f }
      ]
    end

    def parse_date(month_and_year_string)
      year, month = month_and_year_string.split('/')
      "#{year}-#{month.to_s.rjust(2, '0')}-01"
    end
  end
end
