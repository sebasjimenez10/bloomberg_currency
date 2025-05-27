# frozen_string_literal: true

module BC
  module API
    # Implements string parsing
    class Parser
      class << self
        def parse_price(price_str)
          price_str.delete(',').to_f
        end

        def parse_datetime(datetime_str)
          ::DateTime.strptime(datetime_str, '%I:%M %p %Z %m/%d/%y')
        end
      end
    end
  end
end
