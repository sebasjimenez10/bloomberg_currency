# frozen_string_literal: true
module BloombergCurrency
  module Models
    # Quote Information
    class Quote
      attr_accessor :price, :price_datetime, :quote_details
      def initialize(hash)
        @price          = hash[:price]
        @price_datetime = hash[:price_datetime]
        @quote_details  = hash[:quote_details]
      end
    end
  end
end
