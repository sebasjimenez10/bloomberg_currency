# frozen_string_literal: true
# Site Helper.
# Implements opening a static Bloomberg website and returns a parsed HTML object
module SiteHelper
  def load_mock_site
    begin
      file = File.open('spec/examples/doc.html', 'r')
      text = file.read
    rescue => e
      puts 'An error occured opening up an example bloomberg file'
      raise e
    ensure
      file.close
    end
    Nokogiri::HTML(text)
  end
end
