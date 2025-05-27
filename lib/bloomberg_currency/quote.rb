# frozen_string_literal: true

module BC
  # Quote Information Class
  class Quote
    attr_reader :site, :quote, :price, :last_updated_at, :detail, :success

    def initialize(currency_one, currency_two)
      @site            = BC::API::Site.new(currency_one, currency_two)
      @quote           = @site.quote
      @price           = @quote[:price]
      @last_updated_at = @quote[:last_updated_at]
      @detail          = BC::QuoteDetail.new(@quote[:detail])
      @success         = @quote[:success]
    end

    def success?
      success
    end

    def delta
      price - detail.previous_close
    end

    def delta_percent
      (((price - detail.previous_close) / detail.previous_close) * 100).ceil(2)
    end
  end
end
