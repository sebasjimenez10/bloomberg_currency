# frozen_string_literal: true

module BC
  module API
    # Implements site scrapping
    class Site
      PREV_CLOSE_XPATH              = "//div[contains(@class, 'media-ui-SnapshotChart_prevCloseContainer')]"
      PRICE_CONTAINER_XPATH         = "//div[contains(@class, 'quotePageLayout_')]"
      CURRENT_PRICE_CONTAINER_XPATH = ".//div[contains(@class, 'currentPrice_')]"
      PRICE_TAG_XPATH               = ".//div[contains(@class, 'sized-price')]"
      LAST_UPDATED_AT_XPATH         = ".//time[contains(@class, 'timestamp_timeStamp')]"
      SCRIPT_PATH                   = File.expand_path('../../../../bin/fetch.js', __FILE__)

      def initialize(currency_one, currency_two)
        @currency_one = currency_one
        @currency_two = currency_two
        @document     = load_site
      end

      def quote
        build_quote(@document)
      rescue
        { price: nil, last_updated_at: nil, detail: { prev_close: nil }, success: false }
      end

      private

      def load_site
        ticker = "#{@currency_one}#{@currency_two}:CUR"
        output = `node #{SCRIPT_PATH} #{ticker}`

        return Nokogiri::HTML(output) if $?.success?

        raise "Failed to fetch ticker #{ticker}: #{output}"
      end

      def build_quote(document)
        # Extract values from nodes
        price_container = extract_price_container(document)
        price_str       = extract_price(price_container)
        datetime_str    = extract_datetime(price_container)
        prev_close_str  = extract_prev_close(document)

        # Parse extracted values
        price      = BC::API::Parser.parse_price(price_str)
        prev_price = BC::API::Parser.parse_price(prev_close_str)
        datetime   = BC::API::Parser.parse_datetime(datetime_str)

        { price: price, last_updated_at: datetime, detail: { prev_close: prev_price }, success: true }
      end

      def extract_price_container(document)
        document.xpath(PRICE_CONTAINER_XPATH)
      end

      def extract_price(price_container)
        price_container
          .xpath(CURRENT_PRICE_CONTAINER_XPATH)
          .xpath(PRICE_TAG_XPATH)
          .children
          .to_s
      end

      def extract_datetime(price_container)
        price_container
          .xpath(LAST_UPDATED_AT_XPATH)
          .children
          .to_s
      end

      def extract_prev_close(document)
        document
          .xpath(PREV_CLOSE_XPATH)
          .last
          .children
          .map(&:text)
          .last
      end
    end
  end
end
