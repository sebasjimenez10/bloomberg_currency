# frozen_string_literal: true
require 'open-uri'
require 'nokogiri'
require 'bigdecimal'

module BC
  module API
    # Implements site scrapping
    class Site
      class << self
        def quote(currency_one, currency_two)
          process(currency_one, currency_two)
        end

        private

        def process(currency_one, currency_two)
          site = load_site(currency_one, currency_two)
          parse(site)
        end

        def load_site(currency_one, currency_two)
          file = open("#{BC::API::Host::URL}#{currency_one}#{currency_two}:CUR")
          Nokogiri::HTML(file)
        end

        def parse(document)
          parse_quote(document)
        rescue
          { price: nil, datetime: nil, detail: nil, available: false }
        end

        def parse_quote(document)
          price_container          = document.xpath("//div[contains(@class, 'price-container')]")
          detailed_quote_container = document.xpath("//div[contains(@class, 'detailed-quote')]")

          price_element            = price_container.xpath("//div[@class='price']")
          price_datetime_element   = price_container.xpath("//div[@class='price-datetime']")

          price                    = price_element.text.strip.tr(',', '').to_f
          datetime                 = DateTime.strptime(price_datetime_element.text.strip, 'As of %H:%M %p %z %m/%d/%Y')
          details_hash             = quote_details(detailed_quote_container)

          { price: price, datetime: datetime, detail: BC::QuoteDetail.new(details_hash), available: true }
        end

        def quote_details(container)
          detail_elements = container.xpath("//div[@class='data-table data-table_detailed']").xpath(
            "//div[contains(@class, 'cell') and contains(@class, 'cell__mobile-basic')]"
          )

          details_hash = {}
          details_matrix = detail_elements.map { |a| a.text.strip.split('   ') }
          details_matrix.each do |key_value_array|
            details_hash[key_value_array[0].downcase.tr(' ', '_').to_sym] = key_value_array[1]
          end
          details_hash
        end
      end
    end
  end
end
