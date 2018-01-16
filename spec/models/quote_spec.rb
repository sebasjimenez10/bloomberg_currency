# frozen_string_literal: true
require 'spec_helper'

describe BC::Quote do
  subject do
    BC::Quote.new('USD', 'COP')
  end

  it 'should define price' do
    expect(subject.respond_to?(:price)).to be true
  end

  it 'should define datetime' do
    expect(subject.respond_to?(:datetime)).to be true
  end

  it 'should define detail' do
    expect(subject.respond_to?(:detail)).to be true
  end

  it 'should define available?' do
    expect(subject.respond_to?(:available?)).to be true
  end

  it 'should return true when the exchange is valid' do
    expect(subject.send(:available?)).to be true
  end
end
