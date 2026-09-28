# frozen_string_literal: true

require 'stock_market_days/utility_methods'

module StockMarketDays
  class Calculator
    include UtilityMethods

    attr_reader :market_days_list

    def initialize(market_days_file)
      file_contents = File.open(market_days_file).read
      @market_days_list = file_contents.split("\n").map { |date_s| Date.strptime(date_s, '%Y-%m-%d') }.sort
    end

    def is_market_day?(date=Date.today)
      !market_days_list.bsearch { |md| date <=> md }.nil?
    end

    # gets number of market days between begin_day (excluding) and end_day (including)
    def market_days_between(begin_date, end_date)
      unless (begin_date < end_date) &&  (end_date <= market_days_list.last)
        raise "Please enter a begin date before the end date, prior to #{market_days_list.last}"
      end

      first_index_after(end_date) - first_index_after(begin_date)
    end

    def market_days_from(begin_day, days)
      begin_index = market_days_list.bsearch_index { |md| md >= begin_day }
      if market_days_list[begin_index] == begin_day
        market_days_list[begin_index + days]
      elsif market_days_list[begin_index] > begin_day
        if days == 0
          market_days_list[begin_index - 1]
        else
          offset = days > 0 ? -1 : 0
          market_days_list[begin_index + offset + days]
        end
      else
        raise "Calculator Error - This shouldn't happen in StockMarketDays#market_days_from"
      end
    end

    private

    # index of the first market day after date, or the list size if there is none
    def first_index_after(date)
      market_days_list.bsearch_index { |md| md > date } || market_days_list.size
    end

  end
end
