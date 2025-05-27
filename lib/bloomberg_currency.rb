# frozen_string_literal: true

require 'nokogiri'
require 'bigdecimal'
require 'date'

require 'bloomberg_currency/version'
require 'bloomberg_currency/api'
require 'bloomberg_currency/api/site'
require 'bloomberg_currency/api/parser'
require 'bloomberg_currency/api/site_loader'
require 'bloomberg_currency/api/errors/site_load_error'
require 'bloomberg_currency/quote'
require 'bloomberg_currency/quote_detail'

# Main Gem Module
module BC
end
