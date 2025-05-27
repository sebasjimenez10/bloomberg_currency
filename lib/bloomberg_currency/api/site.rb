# frozen_string_literal: true

module BC
  module API
    # Implements site scrapping
    class Site
      class << self
        def quote(currency_one, currency_two)
          site = load_site(currency_one, currency_two)
          extract_quote(site)
        end

        private

        def load_site(currency_one, currency_two)
          ticker = "#{currency_one}#{currency_two}:CUR"
          script_path = File.expand_path('../../../../bin/fetch.js', __FILE__)
          output = `node #{script_path} #{ticker}`

          return Nokogiri::HTML(output) if $?.success?

          raise "Failed to fetch ticker #{ticker}: #{output}"
        end

        def extract_quote(document)
          build_quote(document)
        rescue
          { price: nil, last_updated_at: nil, success: false }
        end

        def build_quote(document)
          # Extract values from nodes
          price_container = extract_price_container(document)
          price_str       = extract_price(price_container)
          datetime_str    = extract_datetime(price_container)

          # Parse extracted values
          price           = BC::API::Parser.parse_price(price_str)
          datetime        = BC::API::Parser.parse_datetime(datetime_str)

          { price: price, last_updated_at: datetime, success: true }
        end

        def extract_price_container(document)
          document.xpath("//div[contains(@class, 'quotePageLayout_')]")
        end

        def extract_price(price_container)
          price_container
            .xpath(".//div[contains(@class, 'currentPrice_')]")
            .xpath(".//div[contains(@class, 'sized-price')]")
            .children
            .to_s
        end

        def extract_datetime(price_container)
          price_container
            .xpath(".//time[contains(@class, 'timestamp_timeStamp')]")
            .children
            .to_s
        end
      end
    end
  end
end
