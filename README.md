# Bloomberg Currency

[![Build Status](https://travis-ci.org/sebasjimenez10/bloomberg_currency.svg?branch=master)](https://travis-ci.org/sebasjimenez10/bloomberg_currency) [![Code Climate](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/gpa.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency) [![Test Coverage](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/coverage.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/coverage) [![Issue Count](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency/badges/issue_count.svg)](https://codeclimate.com/github/sebasjimenez10/bloomberg_currency)

Bloomberg Currency provides an easy-to-use API to pull currency exchange rates from the Bloomberg sites. If you would like to test out this gem before including it into your project, feel free to clone it, bundle it and run `bin/console` for an interactive prompt.

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

You just basically need to create a new instance of the Site object and then call the `quote` method on it, passing the `<currency_from>` and `<currency_to>` as parameters. Like this:

```
site = BloombergCurrency::API::Site.new
site.quote 'USD', 'EUR'
# => => #<BloombergCurrency::Models::Quote:0x007fdb95161098 @price=#<BigDecimal:7fdb95189930,'0.921E0',9(18)>, @price_datetime=#<DateTime: 2016-11-11T16:47:00-05:00 ((2457704j,78420s,0n),-18000s,2299161j)>, @quote_details={:open=>"0.9180", :day_range=>"0.9156 - 0.9233", :previous_close=>"0.9180", :"52wk_range"=>"0.8612 - 0.9496", :ytd_return=>"0.10%"}>
```
As you could notice it will return a Quote object. This object contains three main attributes: `price`, `price_datetime` and `quote_details`.
Out of those three attributes, the `quote_details` attribute contains a hash, here's an example: `{:open=>"0.9180", :day_range=>"0.9156 - 0.9233", :previous_close=>"0.9180", :"52wk_range"=>"0.8612 - 0.9496", :ytd_return=>"0.10%"}`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

If you would like to contribute please fork the repository, make your changes and create a PR.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sebasjimenez10/bloomberg_currency. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

