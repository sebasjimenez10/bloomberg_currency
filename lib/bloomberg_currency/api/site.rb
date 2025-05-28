# frozen_string_literal: true

# Implements scraping of currency quote data from a site using a provided site loader.
#
# @example
#   site = BC::API::Site.new("USD", "EUR")
#   quote = site.quote
#
# @attr_reader [Object] site_loader The loader responsible for fetching site data.
#
# @!attribute [r] site_loader
#   @return [Object] the site loader used to fetch the site data.
#
# @param currency_one [String] The base currency code (e.g., "USD").
# @param currency_two [String] The quote currency code (e.g., "EUR").
# @param site_loader [Object] The loader class/module used to fetch the site (default: BC::API::SiteLoader).
#
# @method quote
#   Fetches and parses the quote data for the given currency pair.
#   @return [Hash, nil] The parsed quote data as a hash, or nil if not found.
#
# @!visibility private
# @method load_site(site_loader)
#   Loads the site for the currency pair using the provided site loader.
#   @param site_loader [Object] The loader to use for fetching the site.
#   @return [Object] The loaded site document.
#
# @method build_quote_hash(document)
#   Extracts and parses the quote JSON from the loaded site document.
#   @param document [Object] The loaded site document.
#   @return [Hash, nil] The parsed quote data as a hash, or nil if not found.

module BC
  module API
    # Implements site scrapping
    class Site
      JSON_QUOTE_XPATH = "//script[@id='__NEXT_DATA__']"

      attr_reader :site_loader

      def initialize(currency_one, currency_two, site_loader = BC::API::SiteLoader)
        @currency_one = currency_one
        @currency_two = currency_two
        @site_loader  = site_loader
      end

      def quote
        document = load_site(site_loader)
        build_quote_hash(document)
      end

      private

      def load_site(site_loader)
        ticker = "#{@currency_one}#{@currency_two}:CUR"
        site_loader.load_site(ticker)
      end

      def build_quote_hash(document)
        json_tag = document.xpath(JSON_QUOTE_XPATH)
        json_quote = JSON.parse(json_tag.text.strip).dig("props", "pageProps", "quote")
        json_quote
      end
    end
  end
end
