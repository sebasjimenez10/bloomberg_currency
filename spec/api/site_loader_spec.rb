# frozen_string_literal: true

require 'spec_helper'
require 'nokogiri'

RSpec.describe BC::API::SiteLoader do
  describe '.load_site' do
    let(:ticker) { 'USDCOP:CUR' }
    let(:fake_html) { '<html><body>Test</body></html>' }
    let(:fake_status) { instance_double(Process::Status, success?: true) }

    before do
      allow(Open3).to receive(:capture2).and_return([fake_html, fake_status])
    end

    it 'returns a Nokogiri::HTML document when the system call succeeds' do
      expect(described_class.load_site(ticker)).to be_a(Nokogiri::HTML::Document)
    end

    it 'parses the HTML content correctly' do
      result = described_class.load_site(ticker)
      expect(result.at('body').text).to eq('Test')
    end

    context 'when the system call fails' do
      let(:fake_status) { instance_double(Process::Status, success?: false) }

      it 'raises a SiteLoadError' do
        expect {
          described_class.load_site(ticker)
        }.to raise_error(BC::API::Errors::SiteLoadError, /Failed to fetch ticker/)
      end
    end

    context 'with different ticker values' do
      let(:ticker) { 'EURUSD:CUR' }
      let(:fake_html) { '<html><body>EURUSD Content</body></html>' }

      it 'returns a Nokogiri::HTML document with correct content' do
        result = described_class.load_site(ticker)
        expect(result.to_html).to include('EURUSD Content')
      end
    end

    context 'when the HTML is empty' do
      let(:fake_html) { '' }

      it 'returns a Nokogiri::HTML document with empty body' do
        result = described_class.load_site(ticker)
        expect(result.at('body')).to be_nil
      end
    end
  end
end
