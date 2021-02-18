# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'pry-byebug'
require 'simplecov'
require 'bloomberg_currency'
require 'webmock/rspec'
require 'vcr'

# RSpec.configure do |c|
#   c.include SiteHelper
# end

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/cassettes"
  config.hook_into :webmock

  config.default_cassette_options = {
    record: :once,
    match_requests_on: %i[method uri],
    decode_compressed_response: true
  }

  config.configure_rspec_metadata!

  config.before_record do |i|
    i.response.body.force_encoding("UTF-8")
  end
end
