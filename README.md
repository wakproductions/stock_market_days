# Stock Market Days

This is a gem to determine whether the US stock market is open on a given day, and calculate the number of trading
days between two dates. All dates are based on the [NYSE calendar](https://www.nyse.com/markets/hours-calendars).

Typically, markets are closed on weekends and the following holidays:

* New Year's Day (January 1st, or first Monday of January if on weekend)
* Martin Luther King Day (third Monday of January)
* Washington's Birthday (third Monday of Feburary)
* Good Friday (Determined by http://www.maa.clell.de/StarDate/publ_holidays.html)
* Memorial Day (last Monday of May)
* Independence Day (July 4, or July 3rd if on Saturday, July 5th if on Sunday)
* Labor Day (First Monday of September)
* Thanksgiving Day (Fourth Thursday of November)
* Christmas Day (December 25th, or December 24th if on Saturday, December 26th if on Sunday) 

Right now the calculation of dates is limited to before 12/31/2059, but that should give you plenty of time
to get rich!

## Installation

In your Gemfile:

```ruby
gem 'stock_market_days', git: 'https://github.com/wakproductions/stock_market_days.git'
```

## Available Methods

`is_market_day?` - tells you whether the given date is a date US markets are open
`market_days_between` - tells number of trading days between two dates
`market_days_from` - gives you the trading day of given date, plus number of trading days 


Look at the test suite for examples of usage.