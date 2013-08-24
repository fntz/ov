# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'Override/version'

Gem::Specification.new do |spec|
  spec.name          = "Override"
  spec.version       = Override::VERSION
  spec.authors       = ["fntzr"]
  spec.email         = ["fantazuor@gmail.com"]
  spec.description   = %q{write overridable methods for fun :)}
  spec.summary       = %q{Override gem provides hacks for write polymorphic methods in Ruby.}
  spec.homepage      = "https://github.com/fntzr/Override"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.0"
end
