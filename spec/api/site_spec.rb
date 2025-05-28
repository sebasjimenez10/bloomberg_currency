# frozen_string_literal: true

require 'spec_helper'

describe BC::API::Site do
  let(:currency_one) { 'USD' }
  let(:currency_two) { 'EUR' }
  let(:test_site_loader) { BC::API::TestSiteLoader }

  subject { BC::API::Site.new(currency_one, currency_two, test_site_loader) }

  it 'defines a public class method called ::quote' do
    expect(subject.methods.include?(:quote)).to be true
  end

  describe '#quote' do
    context 'when loading site succeeds' do
      it 'returns a quote object' do
        expect(subject.quote.class).to eq(Hash)
      end

      it 'returns a quote with price' do
        expect(subject.quote["price"].class).to eq(String)
        expect(subject.quote["price"]).to eq("4,113.8500")
      end

      it 'returns a quote with last_updated_at' do
        expect(subject.quote["lastUpdate"].class).to eq(String)
        expect(subject.quote["lastUpdate"].to_s).to eq("2025-05-27T17:59:55.000Z")
      end
    end

    context 'when currency exchange is not available' do
      before do
        allow(test_site_loader).to receive(:load_site).and_raise(BC::API::Errors::SiteLoadError, 'invalid')
      end

      it 'returns an empty not available quote' do
        expect { subject.quote }.to raise_error(BC::API::Errors::SiteLoadError, /invalid/)
      end
    end
  end
end
