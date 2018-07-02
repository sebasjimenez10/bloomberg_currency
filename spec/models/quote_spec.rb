# frozen_string_literal: true

require 'spec_helper'

describe BC::Quote do
  context 'United States Dollar to Colombia Peso' do
    subject do
      BC::Quote.new('USD', 'COP')
    end

    it 'should define price' do
      expect(subject.price).to be_truthy
    end

    it 'should define datetime' do
      expect(subject.datetime).to be_truthy
    end

    it 'should define detail' do
      expect(subject.detail).to be_truthy
    end

    it 'should define available?' do
      expect(subject.available).to be_truthy
    end

    it 'should return true when the exchange is valid' do
      expect(subject.available?).to be_truthy
    end
  end
  
  context 'United States Dollar to Euro' do
    subject do
      BC::Quote.new('USD', 'EUR')
    end

    it 'should define price' do
      expect(subject.price).to be_falsey
    end

    it 'should define datetime' do
      expect(subject.datetime).to be_falsey
    end

    it 'should define detail' do
      expect(subject.detail).to be_falsey
    end

    it 'should define available?' do
      expect(subject.available).to be_falsey
    end

    it 'should return true when the exchange is valid' do
      expect(subject.available?).to be_falsey
    end
  end
end
