# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ov/version'

Gem::Specification.new do |spec|
  spec.name          = "ov"
  spec.version       = Ov::VERSION
  spec.authors       = ["fntz"]
  spec.email         = ["mike.fch1@gmail.com"]
  spec.description   = %q{write overloaded methods for fun :)}
  spec.summary       = %q{ov gem provide hacks for write multimemethods in Ruby.}
  spec.homepage      = "https://github.com/fntz/ov"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", '~> 2.0'
  spec.add_development_dependency "rake", '~> 12.3', '>= 12.3.3'
  spec.add_development_dependency "rspec", '~> 2.14', '>= 2.14.0'
end
