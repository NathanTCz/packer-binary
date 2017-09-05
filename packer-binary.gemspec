# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'packer/binary/version'

Gem::Specification.new do |spec|
  spec.name          = 'packer-binary'
  spec.version       = Packer::Binary::VERSION
  spec.authors       = ['Nathan Cazell']
  spec.email         = ['nathan.cazell@imageapi.com']

  spec.summary       = "A gem to install and interface with HashiCorp's Packer utility"
  spec.homepage      = 'https://github.com/nathantcz/packer-binary'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'coveralls'

  spec.add_runtime_dependency 'rubyzip'
  spec.add_runtime_dependency 'os'
end
