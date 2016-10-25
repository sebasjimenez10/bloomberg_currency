module SiteHelper
  def load_mock_site
    begin
      file = File.open('spec/examples/doc.html', 'r')
      text = file.read
    rescue => e
      raise e
    ensure
      file.close
    end
    Nokogiri::HTML(text)
  end
end
