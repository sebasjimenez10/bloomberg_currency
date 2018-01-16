# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
require 'helpers/site_helper'
require 'bloomberg_currency'

RSpec.configure do |c|
  c.include SiteHelper
end
