module StockMarketDays
  module UtilityMethods

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