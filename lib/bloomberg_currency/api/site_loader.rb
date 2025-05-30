# frozen_string_literal: true

module BC
  module API
    class SiteLoader
      class << self
        SCRIPT_PATH = File.expand_path('../../../../bin/fetch.js', __FILE__)

        def load_site(ticker)
          output, status = Open3.capture2("node #{SCRIPT_PATH} #{ticker}")
          return Nokogiri::HTML(output) if status.success?

          raise BC::API::Errors::SiteLoadError, "Failed to fetch ticker #{ticker}: #{output}"
        end
      end
    end
  end
end
