# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rcore_ext/version'

Gem::Specification.new do |spec|
  spec.name          = "rcore-ext"
  spec.version       = RCoreExt::VERSION
  spec.authors       = ["Abd ar-Rahman Hamidi"]
  spec.email         = ["bakhtiyor.h@gmail.com"]
  spec.description   = %q{Ruby Core Extensions in a gem}
  spec.summary       = %q{Ruby Core Extension}
  spec.homepage      = "https://github.com/hbakhtiyor/rcore-ext"
  spec.license       = "MIT"

  spec.rubyforge_project = "rcore-ext"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "base32"
  spec.add_runtime_dependency "activesupport"
end
