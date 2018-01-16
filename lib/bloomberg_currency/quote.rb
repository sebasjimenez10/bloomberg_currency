# frozen_string_literal: true

module BC
  # Quote Information Class
  class Quote
    attr_accessor :price, :datetime, :detail, :available
    def initialize(currency_one, currency_two)
      result     = BC::API::Site.quote(currency_one, currency_two)

      @price     = result[:price]
      @datetime  = result[:datetime]
      @detail    = result[:detail]
      @available = result[:available]
    end

    def available?
      available
    end
  end
end
