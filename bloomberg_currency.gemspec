# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bloomberg_currency/version'

Gem::Specification.new do |spec|
  spec.name          = 'bloomberg_currency'
  spec.version       = BC::VERSION
  spec.authors       = ['Sebastian Jimenez Velez']
  spec.email         = ['sebastian@rocktlab.com']

  spec.summary       = 'Bloomberg Currency helps you pull currency rates data from the Bloomberg website'
  spec.description   = 'Provides an easy to use API to get currency rates data from the Bloomberg website'
  spec.homepage      = 'https://github.com/sebasjimenez10/bloomberg_currency'
  spec.license       = 'MIT'

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Runtime dependencies
  spec.add_runtime_dependency 'bigdecimal'
  spec.add_runtime_dependency 'faraday',  '~> 2.13'
  spec.add_runtime_dependency 'nokogiri', '~> 1.18'

  # Development dependencies
  spec.add_development_dependency 'bundler',       '~> 2.6'
  spec.add_development_dependency 'rake',          '~> 13.2'
  spec.add_development_dependency 'rspec',         '~> 3.13'
  spec.add_development_dependency 'simplecov',     '~> 0.22.0'
  spec.add_development_dependency 'rubocop',       '~> 1.75'
  spec.add_development_dependency 'rubocop-rake',  '~> 0.7.1'
  spec.add_development_dependency 'rubocop-rspec', '~> 3.6.0'
  spec.add_development_dependency 'pry-byebug',    '~> 3.11'
end
