# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'helpers/site_helper'
require 'simplecov'
require 'bloomberg_currency'

RSpec.configure do |c|
  c.include SiteHelper
end
