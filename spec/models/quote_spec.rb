# frozen_string_literal: true
require 'spec_helper'

describe BloombergCurrency::Models::Quote do
  subject do
    BloombergCurrency::Models::Quote.new(
      price: BigDecimal.new('2900'),
      price_datetime: Time.now.to_i,
      quote_details: {}
    )
  end

  it 'should define price' do
    expect(subject.respond_to?(:price)).to be true
  end

  it 'should define price_datetime' do
    expect(subject.respond_to?(:price_datetime)).to be true
  end

  it 'should define quote_details' do
    expect(subject.respond_to?(:quote_details)).to be true
  end
end
