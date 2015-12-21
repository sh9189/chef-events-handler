# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'event_reporting_handler/version'

Gem::Specification.new do |spec|
  spec.name          = 'event-reporting-handler'
  spec.version       = BloombergLP::EventReportingHandler::VERSION
  spec.authors       = ['Shahul Khajamohideen']
  spec.email         = ['skhajamohid1@bloomberg.net']

  spec.summary       = 'Chef handler to send events to http url. Also sends chef run failures to sentry'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/sh9189/event-reporting-handler'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'

  spec.add_runtime_dependency 'sentry-raven', '~> 0.15.2'
end
