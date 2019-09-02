module StockMarketDays
  module UtilityMethods

    def market_days_from(begin_day, days, market_days_list: nil)
      f=MARKET_DAYS_FILE
      counter = nil
      File.open(f) do |f|
        f.any? do |line|
          counter +=1 unless counter.nil?
          line_date = Date.strptime(line.strip, '%m/%d/%y')
          counter = 0 if counter.nil? && line_date >= begin_day
          return line_date if counter == days
        end
      end
    end

    def next_market_day(current_market_date=Date.today, market_days_list: nil)
      f=MARKET_DAYS_FILE
      File.open(f) do |f|
        f.any? do |line|
          line_date = Date.strptime(line.strip, '%m/%d/%y')
          return line_date if line_date > current_market_date
        end
      end
    end

    def time_strip_date(time)
      time.to_r / 86400 % 1
    end

    def time_strip_time_zone(time)
      Time.parse(time.strftime('%a, %d %b %Y %H:%M:%S'))
    end

    def compare_time(time1, time2)
      (time1.to_r / 86400) % 1 <=> (time2.to_r / 86400) % 1
    end
  end
end