# frozen_string_literal: true
require 'spec_helper'

describe BloombergCurrency::API::Site do
  let(:currency_one) { 'USD' }
  let(:currency_two) { 'EUR' }

  subject { BloombergCurrency::API::Site.new }

  it 'defines a public method called #quote' do
    expect(subject.methods.include?(:quote)).to be true
  end

  describe '#quote' do
    context 'when stubbing load_site' do
      before do
        allow(subject).to receive(:load_site).and_return(load_mock_site)
      end

      it 'returns a quote object' do
        expect(subject.quote(currency_one, currency_two).class).to eq(BloombergCurrency::Models::Quote)
      end

      it 'returns a quote with price' do
        expect(subject.quote(currency_one, currency_two).price.class).to eq(BigDecimal)
        expect(subject.quote(currency_one, currency_two).price.to_f).to eq(2938.57)
      end

      it 'returns a quote with price details' do
        expect(subject.quote(currency_one, currency_two).quote_details.class).to eq(Hash)
        expect(subject.quote(currency_one, currency_two).quote_details[:previous_close]).to eq('2,933.17')
        expect(subject.quote(currency_one, currency_two).quote_details[:'52wk_range']).to eq('2,784.69 - 3,452.55')
        expect(subject.quote(currency_one, currency_two).quote_details[:ytd_return]).to eq('-7.43%')
      end
    end

    context 'when loading site directly' do
      it 'returns a quote object' do
        expect(subject.quote(currency_one, currency_two).class).to eq(BloombergCurrency::Models::Quote)
      end
    end
  end
end
