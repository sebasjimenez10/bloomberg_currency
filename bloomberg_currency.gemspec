# frozen_string_literal: true
# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bloomberg_currency/version'

Gem::Specification.new do |spec|
  spec.name          = 'bloomberg_currency'
  spec.version       = BC::VERSION
  spec.authors       = ['Sebastian Jimenez Velez']
  spec.email         = ['sebasjimenezv@gmail.com']

  spec.summary       = 'Bloomberg Currency helps you pull currency rates data from the Bloomberg website'
  spec.description   = 'Provides an easy to use API to get currency rates data from the Bloomberg website'
  spec.homepage      = 'https://github.com/sebasjimenez10/bloomberg_currency'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.11'
  spec.add_development_dependency 'rubocop', '~> 0.45.0'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0.0'

  spec.add_runtime_dependency 'nokogiri', '~> 1.6', '>= 1.6.8'
end
