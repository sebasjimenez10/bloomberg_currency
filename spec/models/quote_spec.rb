# frozen_string_literal: true

require 'spec_helper'

describe BC::Quote, :vcr, type: :request do
  subject do
    BC::Quote.new('USD', 'COP')
  end

  it 'defines price' do
    expect(subject.respond_to?(:price)).to be true
  end

  it 'returns the expected price' do
    expect(subject.price).to eq 3531.87
  end

  it 'defines datetime' do
    expect(subject.respond_to?(:datetime)).to be true
  end

  it 'returns the expected datetime' do
    expect(subject.datetime.to_date.to_s).to eq "2021-02-17"
  end

  it 'defines detail' do
    expect(subject.respond_to?(:detail)).to be true
  end

  it 'defines available?' do
    expect(subject.respond_to?(:available?)).to be true
  end

  it 'returns true when the exchange is valid' do
    expect(subject.send(:available?)).to be true
  end
end
