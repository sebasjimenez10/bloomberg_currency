# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry-byebug'
require 'simplecov'
require 'bloomberg_currency'

module BC
  module API
    class TestSiteLoader
      class << self
        SITE_PATH = File.expand_path('../fixtures/usdcop_cur.html', __FILE__)

        def load_site(ticker)
          output = File.read(SITE_PATH)
          return Nokogiri::HTML(output)
        end
      end
    end
  end
end
