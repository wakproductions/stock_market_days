require 'stock_market_days/utility_methods'

module StockMarketDays
  class Calculator
    include UtilityMethods

    attr_reader :market_days_list

    def initialize(market_days_file)
      file_contents = File.open(market_days_file).read
      @market_days_list = file_contents.split("\n").map { |date_s| Date.parse(date_s) }
    end

    def is_market_day?(date=Date.today)
      market_days_list.include?(date)
    end

    # gets number of market days between begin_day (excluding) and end_day (including)
    def market_days_between(begin_date, end_date)
      unless (begin_date < end_date) &&  (end_date <= market_days_list.max)
        raise "Please enter a begin date before the end date, prior to #{market_days_list.max}"
      end

      days_between=0
      market_days_list.any? do |date|
        if date > begin_date && date <= end_date
          days_between += 1
        end
        return days_between if date > end_date
      end
      days_between
    end

    def market_days_from(begin_day, days)
      begin_index = market_days_list.index(
        market_days_list.find { |md| md >= begin_day }
      )
      if market_days_list[begin_index] == begin_day
        market_days_list[begin_index + days]
      elsif market_days_list[begin_index] > begin_day
        market_days_list[begin_index - 1 + days]
      else
        raise "Calculator Error - This shouldn't happen in StockMarketDays#market_days_from"
      end
    end


  end
end