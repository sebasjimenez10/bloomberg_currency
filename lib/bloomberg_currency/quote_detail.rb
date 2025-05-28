# frozen_string_literal: true

# Represents detailed information for a currency quote.
#
# == Example
#
#   quote_detail = BC::QuoteDetail.new(
#     prev_close: 100.0,
#     low: 95.0,
#     high: 105.0,
#     open: 98.0,
#     day_range: (95.0..105.0),
#     fifty_two_week_range: (90.0..110.0),
#     total_return_ytd: 5.0
#   )
#   puts quote_detail.previous_close       # => 100.0
#   puts quote_detail.low                  # => 95.0
#   puts quote_detail.high                 # => 105.0
#   puts quote_detail.open                 # => 98.0
#   puts quote_detail.day_range            # => 95.0..105.0
#   puts quote_detail.fifty_two_week_range # => 90.0..110.0
#   puts quote_detail.total_return_ytd     # => 5.0
#
# == Attributes
#
# * +previous_close+ - The previous closing price (Float)
# * +low+ - The lowest price of the day (Float)
# * +high+ - The highest price of the day (Float)
# * +open+ - The opening price (Float)
# * +day_range+ - The price range for the day (Range)
# * +fifty_two_week_range+ - The 52-week price range (Range)
# * +total_return_ytd+ - The total return year-to-date (Float)
#
# == See Also
#
# * BC::Quote
# * BC::API::Site
module BC
  # Represents a currency quote detail
  class QuoteDetail
    attr_reader :previous_close, :low, :high, :open, :day_range, :fifty_two_week_range, :total_return_ytd

    def initialize(attributes = {})
      @previous_close       = BC::API::Parser.parse_price(attributes[:prev_close])
      @low                  = attributes[:low]
      @high                 = attributes[:high]
      @open                 = BC::API::Parser.parse_price(attributes[:open])
      @day_range            = BC::API::Parser.parse_price_range(attributes[:day_range])
      @fifty_two_week_range = BC::API::Parser.parse_price_range(attributes[:fifty_two_week_range])
      @total_return_ytd     = BC::API::Parser.parse_tr_ytd(attributes[:total_return_ytd])
    end
  end
end
