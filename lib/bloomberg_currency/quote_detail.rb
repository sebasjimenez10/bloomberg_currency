# frozen_string_literal: true

module BC
  # Quote Details Class
  class QuoteDetail
    attr_reader :previous_close

    def initialize(attributes = {})
      @previous_close = attributes[:prev_close]
    end
  end
end
