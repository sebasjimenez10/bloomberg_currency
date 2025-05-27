# frozen_string_literal: true

module BC
  # Quote Information Class
  class Quote
    attr_accessor :price, :last_updated_at, :detail, :success

    def initialize(currency_one, currency_two)
      result = BC::API::Site.quote(currency_one, currency_two)

      @price           = result[:price]
      @last_updated_at = result[:last_updated_at]
      @success         = result[:success]
      # @detail    = result[:detail]
    end

    def success?
      success
    end
  end
end
