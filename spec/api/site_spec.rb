# frozen_string_literal: true
require 'spec_helper'

describe BC::API::Site do
  let(:currency_one) { 'USD' }
  let(:currency_two) { 'EUR' }

  subject { BC::API::Site }

  it 'defines a public class method called ::quote' do
    expect(subject.methods.include?(:quote)).to be true
  end

  describe '#quote' do
    context 'when stubbing load_site' do
      before do
        allow(subject).to receive(:load_site).and_return(load_mock_site)
      end

      it 'returns a quote object' do
        expect(subject.quote(currency_one, currency_two).class).to eq(Hash)
      end

      it 'returns a quote with price' do
        expect(subject.quote(currency_one, currency_two)[:price].class).to eq(Float)
        expect(subject.quote(currency_one, currency_two)[:price].to_f).to eq(2864.64)
      end

      it 'returns a quote with price details' do
        expect(subject.quote(currency_one, currency_two)[:detail].class).to eq(BC::QuoteDetail)
        expect(subject.quote(currency_one, currency_two)[:detail].previous_close).to eq(2840.98)
        expect(subject.quote(currency_one, currency_two)[:detail].last_52_weeks_range).to eq(2831.07..3102.62)
        expect(subject.quote(currency_one, currency_two)[:detail].ytd_return).to eq(-3.99)
      end
    end

    context 'when loading site directly' do
      it 'returns a quote object' do
        expect(subject.quote(currency_one, currency_two).class).to eq(Hash)
      end
    end

    context 'when currency exchange is not available' do
      before do
        allow(subject).to receive(:parse_quote).and_raise('invalid_exchange')
      end

      it 'should return an empty not available quote' do
        expect(subject.quote(currency_one, currency_two)[:available]).to eq false
      end
    end
  end
end
