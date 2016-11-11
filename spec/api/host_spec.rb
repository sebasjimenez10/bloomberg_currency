# frozen_string_literal: true
require 'spec_helper'

describe BloombergCurrency::API::Host do
  subject { BloombergCurrency::API::Host }

  it 'should have defined the URL' do
    expect(subject::URL).to eql 'https://www.bloomberg.com/quote/'
  end
end
