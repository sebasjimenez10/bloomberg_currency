# frozen_string_literal: true

# = BC
#
# The BC module provides classes and methods for retrieving and representing currency quotes
# from Bloomberg. It acts as a namespace for all related classes, including {BC::Quote},
# {BC::API::Site}, {BC::API::Parser}, and {BC::QuoteDetail}.
#
# == Examples
#
#   quote = BC::Quote.new(currency_one: "USD", currency_two: "COP")
#   puts quote.name            # => "US Dollar / Colombian Peso"
#   puts quote.price           # => 4000.0
#   puts quote.delta           # => 10.5
#   puts quote.delta_percent   # => 0.26
#   puts quote.last_updated_at # => 2024-06-10 15:30:00 +0000
#
# == See Also
#
# * BC::API::Site
# * BC::API::Parser
# * BC::QuoteDetail
#
# == Errors
#
# * BC::API::Errors::SiteLoadError - if the site cannot be loaded
# * JSON::ParserError - if the JSON cannot be parsed
module BC
  # Represents a currency quote
  class Quote
    attr_reader :name, :detail, :price, :delta, :delta_percent, :last_updated_at

    def initialize(currency_one:, currency_two:)
      quote_data       = BC::API::Site.new(currency_one, currency_two).quote

      @price           = BC::API::Parser.parse_price(quote_data["price"])
      @last_updated_at = BC::API::Parser.parse_datetime(quote_data["lastUpdate"])
      @delta           = quote_data["priceChange1Day"]
      @delta_percent   = quote_data["percentChange1Day"]
      @name            = quote_data["longName"]
      @detail          = build_quote_detail(quote_data)
    end

    private

    def build_quote_detail(quote_data)
      args = {
        low:                  quote_data["lowPrice"],
        high:                 quote_data["highPrice"],
        open:                 quote_data["openPrice"],
        prev_close:           quote_data["prevClose"],
        day_range:            quote_data["dayRange"],
        fifty_two_week_range: quote_data["fiftyTwoWeekRange"],
        total_return_ytd:     quote_data["totalReturnYtd"]
      }

      BC::QuoteDetail.new(args)
    end
  end
end
