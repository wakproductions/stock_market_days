# This file is just the routines I've used to build the date list, which can be manually modified.

require 'csv'

module ManuallyInvokedBuild
  module HolidayCalculator
    module_function

    def market_dates(year_range, good_friday_dates=[])
      holidays = year_range.flat_map do |year|
        [
          new_years_day_for(year),
          mlk_day_for(year),
          presidents_day_for(year),
          memorial_day_for(year),
          independence_day_for(year),
          labor_day_for(year),
          thanksgiving_day_for(year),
          christmas_for(year)
        ]
      end

      date_range = (Date.new(year_range.min, 1, 1)..Date.new(year_range.max, 1, 1))
      date_range.reject do |date|
        date.saturday? ||
        date.sunday? ||
        good_friday_dates.include?(date) ||
        holidays.include?(date)
      end
    end

#     * New Year's Day (January 1st, or first Monday of January if on weekend)
#     * Martin Luther King Day (third Monday of January)
#     * Washington's Birthday (third Monday of Feburary)
#     * Good Friday (Determined by http://www.maa.clell.de/StarDate/publ_holidays.html)
#     * Memorial Day (last Monday of May)
#     * Independence Day (July 4, or July 3rd if on Saturday, July 5th if on Sunday)
#     * Labor Day (First Monday of September)
#     * Thanksgiving Day (Fourth Thursday of November)
#     * Christmas Day (December 25th, or December 24th if on Saturday, December 26th if on Sunday)

    def new_years_day_for(year)
      nyd = Date.new(year,1,1)
      if nyd.saturday?
        Date.new(year,1,3)
      elsif nyd.sunday?
        Date.new(year,1,2)
      else
        nyd
      end
    end

    def mlk_day_for(year)
      (15..21).map { |day| Date.new(year,1,day) }.find { |date| date.monday? }
    end

    def presidents_day_for(year)
      (15..21).map { |day| Date.new(year,2,day) }.find { |date| date.monday? }
    end

    def good_friday_list(csv_text)
      CSV
        .parse(csv_text, headers: true, col_sep: "\t")
        .map do |line|
          day, month = line["Good Friday"].split('.')
          Date.new(line['Year'].to_i, month.to_i, day.to_i)
        end
    end

    def memorial_day_for(year)
      (25..31).map { |day| Date.new(year,5,day) }.find { |date| date.monday? }
    end

    def independence_day_for(year)
      id = Date.new(year,7,4)
      if id.saturday?
        Date.new(year,7,3)
      elsif id.sunday?
        Date.new(year,7,5)
      else
        id
      end
    end

    def labor_day_for(year)
      (1..6).map { |day| Date.new(year,9,day) }.find { |date| date.monday? }
    end

    def thanksgiving_day_for(year)
      (22..29).map { |day| Date.new(year,11,day) }.find { |date| date.thursday? }
    end

    def christmas_for(year)
      xmas = Date.new(year,12,25)
      if xmas.saturday?
        Date.new(year,12,24)
      elsif xmas.sunday?
        Date.new(year,12,26)
      else
        xmas
      end
    end
  end
end