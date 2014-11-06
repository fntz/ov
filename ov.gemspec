# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ov/version'

Gem::Specification.new do |spec|
  spec.name          = "ov"
  spec.version       = Ov::VERSION
  spec.authors       = ["fntzr"]
  spec.email         = ["fantazuor@gmail.com"]
  spec.description   = %q{write overloaded methods for fun :)}
  spec.summary       = %q{ov gem provides hacks for write multimemethods in Ruby.}
  spec.homepage      = "https://github.com/fntzr/ov"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.0"
end
