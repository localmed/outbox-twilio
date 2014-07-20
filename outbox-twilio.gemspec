# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'outbox/twilio/version'

Gem::Specification.new do |spec|
  spec.name          = 'outbox-twilio'
  spec.version       = Outbox::Twilio::VERSION
  spec.authors       = ['Pete Browne']
  spec.email         = ['pete.browne@localmed.com']
  spec.summary       = %q{Outbox SMS client for Twilio.}
  spec.description   = %q{Twilio API wrapper for Outbox, a generic interface for sending notificatons.}
  spec.homepage      = 'https://github.com/localmed/outbox-twilio'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'outbox', '~> 0.2'
  spec.add_runtime_dependency 'twilio-ruby', '~> 3.11'
  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end
