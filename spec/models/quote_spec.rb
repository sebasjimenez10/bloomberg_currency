# frozen_string_literal: true

require 'spec_helper'

describe BC::Quote do
  subject do
    BC::Quote.new(currency_one: 'USD', currency_two: 'COP')
  end

  let(:test_site_loader) { BC::API::TestSiteLoader }
  let(:test_site) { BC::API::Site.new('USD', 'COP', test_site_loader) }

  before do
    allow(BC::API::Site).to receive(:new).with('USD', 'COP').and_return(test_site)
    allow(test_site).to receive(:quote).and_call_original
  end

  it 'defines price' do
    expect(subject.respond_to?(:price)).to be true
  end

  it 'returns the expected price' do
    expect(subject.price).to eq 4113.85
  end

  it 'defines last_updated_at' do
    expect(subject.respond_to?(:last_updated_at)).to be true
  end

  it 'returns the expected last_updated_at' do
    expect(subject.last_updated_at.to_s).to eq "2025-05-27T17:59:55+00:00"
  end

  it 'defines detail' do
    expect(subject.respond_to?(:detail)).to be true
  end

  it 'returns price delta' do
    expect(subject.delta).to eq -36.85
  end

  it 'returns price delta percentage' do
    expect(subject.delta_percent).to eq -0.8877999782562256
  end
end
