# frozen_string_literal: true

module BC
  module API
    # Provides methods to parse various data types from strings
    # such as prices, datetimes, and ranges.
    #
    # @example
    #   price = BC::API::Parser.parse_price("$1,234.56")
    #   puts price # => 1234.56
    #   datetime = BC::API::Parser.parse_datetime("2023-10-01T12:00:00.000Z")
    #   puts datetime # => #<DateTime: 2023-10-01T12:00:00+00:00 ((2459550j,43200s,0n),+0s,2299161j)>
    #   tr_ytd = BC::API::Parser.parse_tr_ytd("5%")
    #   puts tr_ytd # => 5.0
    #   price_range = BC::API::Parser.parse_price_range(["$1,000.00", "$1,500.00"])
    #   puts price_range # => 1000.0..1500.0
    # @see BC::API::Site
    # @see BC::Quote
    # @see BC::QuoteDetail
    class Parser
      class << self
        def parse_price(price_str)
          raw_price_str = price_str.gsub(/[^\d.,\-]/, '')
          raw_price_str.delete(',').to_f
        end

        def parse_datetime(datetime_str)
          ::DateTime.strptime(datetime_str, '%Y-%m-%dT%H:%M:%S.%LZ')
        end

        def parse_tr_ytd(tr_ytd_str)
          tr_ytd_str.delete("%").tr("–—−", "-").to_f
        end

        def parse_price_range(price_range_arr)
          lower = parse_price(price_range_arr[0])
          upper = parse_price(price_range_arr[1])
          lower..upper
        end
      end
    end
  end
end
