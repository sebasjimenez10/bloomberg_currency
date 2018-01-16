# frozen_string_literal: true

module BC
  # Quote Details Class
  class QuoteDetail
    attr_accessor :open, :day_range, :previous_close, :last_52_weeks_range, :ytd_return

    def initialize(attributes = {})
      @open                = process_float(attributes[:open])
      @day_range           = process_range(attributes[:day_range])
      @previous_close      = process_float(attributes[:previous_close])
      @last_52_weeks_range = process_range(attributes[:"52wk_range"])
      @ytd_return          = process_float(attributes[:ytd_return])
    end

    private

    def process_range(range)
      return unless range
      edges = range.tr(',', '').strip.split('-')
      edges[0].to_f..edges[1].to_f
    end

    def process_float(float)
      return unless float
      float.tr(',', '').to_f
    end
  end
end
