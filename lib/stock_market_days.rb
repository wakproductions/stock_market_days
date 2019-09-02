require 'date'
require 'stock_market_days/calculator'

module StockMarketDays
  MARKET_DAYS_FILE=File.join(File.dirname(__FILE__), 'market_open_days', 'nyse_market_days.csv')

  @@default_calculator = StockMarketDays::Calculator.new(MARKET_DAYS_FILE)

  class << self
    def is_market_day?(date = Date.today)
      @@default_calculator.is_market_day?(date)
    end

    def market_days_between(begin_date, end_date)
      @@default_calculator.market_days_between(begin_date, end_date)
    end
  end

end