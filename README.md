# Bloomberg Currency

[![Build Status](https://github.com/sebasjimenez10/bloomberg_currency/actions/workflows/ci.yml/badge.svg)](https://github.com/sebasjimenez10/bloomberg_currency/actions/workflows/ci.yml)
[![Test Coverage](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/coverage.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/coverage)
[![Gem Version](https://badge.fury.io/rb/bloomberg_currency.svg)](https://badge.fury.io/rb/bloomberg_currency)

Bloomberg Currency provides an easy-to-use API to pull currency exchange rates from the Bloomberg site. If you would like to test out this gem before including it into your project, feel free to clone it, bundle it and run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloomberg_currency'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bloomberg_currency

## Usage

_NOTE_: From version `1.1.2` to `2.0.0` there are mayor breaking changes. Please make sure you read the docs before installing/upgrading to the newest version.

_NOTE_: From version `0.1.0` to `1.0.0` there are mayor breaking changes. Please make sure you read the docs before installing/upgrading to the newest version.

```
quote = BC::Quote.new('USD', 'EUR')
=>
#<BC::Quote:0x000000011bee6a08
 @detail=#<BC::QuoteDetail:0x000000011dcd5de8 @previous_close=0.8827>,
 @last_updated_at=#<DateTime: 2025-05-28T06:38:00-04:00 ((2460824j,38280s,0n),-14400s,2299161j)>,
 @price=0.8822,
 @quote=
  {:price=>0.8822, :last_updated_at=>#<DateTime: 2025-05-28T06:38:00-04:00 ((2460824j,38280s,0n),-14400s,2299161j)>, :detail=>{:prev_close=>0.8827}, :success=>true},
  ...

quote.detail
=> #<BC::QuoteDetail:0x000000011dcd5de8 @previous_close=0.8827>
```

Then the quote object offers a few accessor methods:

- `price`: Returns a float price
- `last_updated_at`: Returns the date time when the price was last updated
- `detail`: Returns an object of the class BC::QuoteDetail which encapsulate the details of the quote.
- `success?`: Returns true or false if the quote was successful or not.
- `delta`: Returns the difference between current price and previous close price.
- `delta_percent`: Returns the percentage difference between current price and previous close price.

The `BC::QuoteDetail` class offers the following methods:

- `previous_close`: Returns the value where the exchange closed last day.

## Examples

Getting information about the USD and EUR exchange:

```
quote = BC::Quote.new('USD', 'EUR')
quote.price
=> 0.8147

quote.last_updated_at
=> #<DateTime: 2025-05-28T06:38:00-04:00 ((2460824j,38280s,0n),-14400s,2299161j)>

quote.detail
=> #<BC::QuoteDetail:0x000000011dcd5de8 @previous_close=0.8827>

quote.success?
=> true

quote.delta
=> -0.0

quote.delta_percent
=> -0.05
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
