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
        expect(subject.quote[:price].class).to eq(Float)
        expect(subject.quote[:price].to_f).to eq(4113.85)
      end

      it 'returns a quote with last_updated_at' do
        expect(subject.quote[:last_updated_at].class).to eq(DateTime)
        expect(subject.quote[:last_updated_at].to_s).to eq("2025-05-27T13:59:00-04:00")
      end

      it 'returns a quote with price details' do
        expect(subject.quote[:detail].class).to eq(Hash)
        expect(subject.quote[:detail][:prev_close]).to eq(4150.70)
      end
    end

    context 'when currency exchange is not available' do
      before do
        allow(test_site_loader).to receive(:load_site).and_raise(BC::API::Errors::SiteLoadError, 'invalid')
      end

      it 'returns an empty not available quote' do
        expect(subject.quote[:success]).to eq false
      end
    end
  end
end
