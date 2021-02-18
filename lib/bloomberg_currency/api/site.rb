# frozen_string_literal: true

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
          url = "#{BC::API::Host::URL}#{currency_one}#{currency_two}:CUR"
          headers = {
            'user-agent' => BC::API::USER_AGENT,
            'referer' => 'https://www.google.com/'
          }
          file = Faraday.get(url, nil, headers)

          Nokogiri::HTML(file.body)
        end

        def parse(document)
          parse_quote(document)
        rescue
          { price: nil, datetime: nil, detail: nil, available: false }
        end

        def parse_quote(document)
          price_container          = document.xpath("//section[contains(@class, 'quotePageSnapshot')]")
          detailed_quote_container = document.xpath("//div[contains(@class, 'details__')]")
          price_element            = price_container.xpath("//span[starts-with(@class, 'priceText__')]")
          price_datetime_element   = price_container.xpath("//div[contains(@class, 'time__')]")
          price                    = price_element.text.strip.tr(',', '').to_f
          datetime                 = calculate_datetime(price_datetime_element.children.first.text.strip)
          details_hash             = quote_details(detailed_quote_container)

          { price: price, datetime: datetime, detail: BC::QuoteDetail.new(details_hash), available: true }
        end

        def quote_details(container)
          open_price = extract_value_from_detail(container, 'openprice')
          previous_close = extract_value_from_detail(container, 'previousclosingpriceonetradingdayago')
          total_return_ytd = extract_value_from_detail(container, 'totalreturnytd')
          range_one_day = extract_values_for_range(container, 'rangeoneday')
          range_52_weeks = extract_values_for_range(container, 'range52weeks')

          {
            open: open_price,
            day_range: range_one_day,
            previous_close: previous_close,
            range_52_wks: range_52_weeks,
            ytd_return: total_return_ytd
          }
        end

        def extract_value_from_detail(container, section)
          container
            .xpath("//section[contains(@class, '#{section}')]")
            .children[1].text
        end

        def extract_values_for_range(container, section)
          container
            .xpath("//section[contains(@class, '#{section}')]")
            .children[1]
            .children[0]
            .children
            .map(&:text)
            .join('-')
        end

        def calculate_datetime(datetime_str)
          if datetime_str.index(':')
            ::DateTime.strptime(datetime_str, 'As of %H:%M %p %z %m/%d/%Y')
          else
            ::DateTime.strptime(datetime_str, 'As of %m/%d/%Y').to_date
          end
        rescue
          ''
        end
      end
    end
  end
end
