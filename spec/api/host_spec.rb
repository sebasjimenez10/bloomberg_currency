# frozen_string_literal: true

require 'spec_helper'

describe BC::API::Host do
  subject { BC::API::Host }

  it 'should have defined the BASE' do
    expect(subject::BASE).to eql 'https://www.bloomberg.com'
  end

  it 'should have defined the PATH' do
    expect(subject::PATH).to eql '/quote/'
  end
end
