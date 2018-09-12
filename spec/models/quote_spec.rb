# frozen_string_literal: true

require 'spec_helper'

describe BC::Quote do
  context 'United States Dollar to Colombian Peso' do
    let(:quote) { BC::Quote.new('USD', 'COP') }

    it 'should define price' do
      expect(quote.price).to be_truthy
    end

    it 'should define datetime' do
      expect(quote.datetime).to be_truthy
    end

    it 'should define detail' do
      expect(quote.detail).to be_truthy
    end

    it 'should define available?' do
      expect(quote.available).to be_truthy
    end

    it 'should return true when the exchange is valid' do
      expect(quote.available?).to be_truthy
    end
  end
  
  context 'United States Dollar to Euro' do
    let(:quote) { BC::Quote.new('USD', 'EUR') }

    it 'should define price' do
      expect(quote.price).to be_falsey
    end

    it 'should define datetime' do
      expect(quote.datetime).to be_falsey
    end

    it 'should define detail' do
      expect(quote.detail).to be_falsey
    end

    it 'should define available?' do
      expect(quote.available).to be_falsey
    end

    it 'should return true when the exchange is valid' do
      expect(quote.available?).to be_falsey
    end
  end
end
