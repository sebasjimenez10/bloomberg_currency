# Bloomberg Currency

[![Build Status](https://travis-ci.org/sebasjimenez10/bloomberg_currency.svg?branch=master)](https://travis-ci.org/sebasjimenez10/bloomberg_currency) [![Code Climate](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/gpa.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency) [![Test Coverage](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/coverage.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/coverage) [![Issue Count](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/issue_count.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency)
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

*NOTE*: From version `0.1.0` to `1.0.0` there are mayor breaking changes. Please make sure you read the docs before installing/upgrading to the newest version.

The gem usability has been improved in version 1.0.0. Now you only need to create an instance of the class `BC::Quote`, passing the two currencies you'd like to get information about, like this:

```
quote = BC::Quote.new('USD', 'EUR')
=> #<BC::Quote:0x00007fd5858f1620 @price=0.8303, @datetime="", @detail=#<BC::QuoteDetail:0x00007fd583330238 @open=0.8307, @day_range=0.8299..0.8307, @previous_close=0.8306, @last_52_weeks_range=0.8098..0.94, @ytd_return=1.43>, @available=true>
quote.detail
=> #<BC::QuoteDetail:0x00007fd583330238 @open=0.8307, @day_range=0.8299..0.8307, @previous_close=0.8306, @last_52_weeks_range=0.8098..0.94, @ytd_return=1.43>
```

Then the quote object offers a few accessor methods:

- `price`: Returns a float price
- `datetime`: Returns the date time when the price was captured
- `detail`: Returns an object of the class BC::QuoteDetail which encapsulate the details of the quote. Will be explained later on.
- `available?`: Return true or false if the exchange is available or not.


The `BC::QuoteDetail` class offers the following methods:

- `open`: Returns the value in which the currency opened.
- `day_range`: Returns the day range up until the moment the quote is generated.
- `previous_close`: Returns the value where the exchange closed last day.
- `last_52_weeks_range`: Returns the range od the last 52 weeks.
- `ytd_return`: Returns the YTD percentage.


*NOTE*: When the some of the markets close, the `open` and `day_range` attributes on the Bloomberg site aren't displayed. So those attributes may not be present if the market is closed. But the quote may still be available.

## Examples

Getting information about the USD and EUR exchange:

```
quote = BC::Quote.new('USD', 'EUR')
quote.price
=> 0.8147

quote.datetime
=> #<DateTime: 2018-01-16T14:35:00-05:00 ((2458135j,70500s,0n),-18000s,2299161j)>

quote.detail
=> #<BC::QuoteDetail:0x007faadd9fb868 @open=0.8154, @day_range=0.8143..0.8199, @previous_close=0.8154, @last_52_weeks_range=0.8133..0.9529, @ytd_return=-1.91>

quote.available?
=> true

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

If you would like to contribute please fork the repository, make your changes and create a PR.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sebasjimenez10/bloomberg_currency. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

