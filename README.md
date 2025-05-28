# Bloomberg Currency

[![Build Status](https://github.com/sebasjimenez10/bloomberg_currency/actions/workflows/ci.yml/badge.svg)](https://github.com/sebasjimenez10/bloomberg_currency/actions/workflows/ci.yml)
[![Gem Version](https://badge.fury.io/rb/bloomberg_currency.svg)](https://badge.fury.io/rb/bloomberg_currency)

Bloomberg Currency provides an easy-to-use API to pull currency exchange rates from the Bloomberg site. If you would like to test out this gem before including it into your project, feel free to clone it, bundle it and run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloomberg_currency'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install bloomberg_currency
```

## Lastest changes

Version `2.0.0` uses Playwright to spin up a headfull chromium browser to load the page content to bypass robot checks. The browser session lasts about ~3 secs. It is recommended to cache results for at least 1 min to prevent being flagged by Bloombergs site.

A `fetch.js` script has been added to `bin`. This script is called from ruby to load the site.

## Usage

_NOTE_: From version `1.1.2` to `2.0.0` there are mayor breaking changes. Please make sure you read the docs before installing/upgrading to the newest version.

_NOTE_: From version `0.1.0` to `1.0.0` there are mayor breaking changes. Please make sure you read the docs before installing/upgrading to the newest version.

```
quote = BC::Quote.new(currency_one: 'USD', currency_two: 'COP')
=>
#<BC::Quote:0x0000000122256368
 @delta=18.36,
 @delta_percent=0.4462999999523163,
 @detail=#<BC::QuoteDetail:0x0000000122178db0 @day_range=4112.38..4136.93, @fifty_two_week_range=3843.94..4545.83, @high=4136.93, @low=4112.38, @open=4120.68, @previous_close=4113.85, @total_return_ytd=-6.21>,
 @last_updated_at=#<DateTime: 2025-05-28T16:45:27+00:00 ((2460824j,60327s,0n),+0s,2299161j)>,
 @name="USDCOP Spot Exchange Rate - Price of 1 USD in COP",
 @price=4132.21>

quote.detail
=> #<BC::QuoteDetail:0x0000000122178db0 @day_range=4112.38..4136.93, @fifty_two_week_range=3843.94..4545.83, @high=4136.93, @low=4112.38, @open=4120.68, @previous_close=4113.85, @total_return_ytd=-6.21>
```

The `BC::Quote` quote object offers the following accessor methods:

- `name` - The name of the currency or financial instrument.
- `detail` - Additional details or description about the currency or instrument.
- `price` - The current price or value.
- `delta` - The absolute change in price since the last update.
- `delta_percent` - The percentage change in price since the last update.
- `last_updated_at` - The timestamp indicating when the data was last updated.

The `BC::QuoteDetail` detail object offers the following accessor methods:

- `previous_close` - The previous closing price (Float)
- `low` - The lowest price of the day (Float)
- `high` - The highest price of the day (Float)
- `open` - The opening price (Float)
- `day_range` - The price range for the day (Range)
- `fifty_two_week_range` - The 52-week price range (Range)
- `total_return_ytd` - The total return year-to-date (Float)

The rest of the classes are intended for internal use and should not be used outside of the `BC::Quote` implementation.

## Examples

Getting information about the USD and COP exchange:

```
quote = BC::Quote.new(currency_one: 'USD', currency_two: 'COP')
=>
#<BC::Quote:0x0000000122256368
 @delta=18.36,
 @delta_percent=0.4462999999523163,
 @detail=#<BC::QuoteDetail:0x0000000122178db0 @day_range=4112.38..4136.93, @fifty_two_week_range=3843.94..4545.83, @high=4136.93, @low=4112.38, @open=4120.68, @previous_close=4113.85, @total_return_ytd=-6.21>,
 @last_updated_at=#<DateTime: 2025-05-28T16:45:27+00:00 ((2460824j,60327s,0n),+0s,2299161j)>,
 @name="USDCOP Spot Exchange Rate - Price of 1 USD in COP",
 @price=4132.21>

# Inspect the quote detail

quote.detail
=> #<BC::QuoteDetail:0x0000000122178db0 @day_range=4112.38..4136.93, @fifty_two_week_range=3843.94..4545.83, @high=4136.93, @low=4112.38, @open=4120.68, @previous_close=4113.85, @total_return_ytd=-6.21>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

The setup step will require node in your machine, as it will install npm dependencies. These are required to run Playwright.

To install this gem onto your local machine, run `bundle exec rake install`.

If you would like to contribute please fork the repository, make your changes and create a PR.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sebasjimenez10/bloomberg_currency. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
