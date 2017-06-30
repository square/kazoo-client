# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kazoo-client/version'

Gem::Specification.new do |spec|
  spec.name          = 'kazoo-client'
  spec.version       = Kazoo::Client::VERSION
  spec.authors       = ['Sean Lazar']
  spec.email         = ['sean@squareup.com']

  spec.summary       = 'Client library gem for use with 2600Hz Kazoo'
  spec.homepage      = "https://github.com/square/kazoo-client"
  spec.license       = 'Apache-2.0'

  spec.add_dependency('http', '~> 2.2', '>= 2.2.2')
  spec.add_development_dependency('bundler', '~> 1.12')
  spec.add_development_dependency('rake', '~> 10.0')
  spec.add_development_dependency('rspec', '~> 3.0')
  spec.add_development_dependency('webmock', '~> 2.1')

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.0.0'
end
