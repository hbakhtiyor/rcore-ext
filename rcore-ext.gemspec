# -*- encoding: utf-8 -*-
$: << File.expand_path("../lib", __FILE__)

require "rcore_ext/version"

Gem::Specification.new do |s|
  s.authors     = ["Bakhtiyor Homidov"]
  s.email       = ["bakhtiyor.h@gmail.com"]
  s.homepage    = "https://github.com/hbakhtiyor/rcore-ext"
  s.description = %q{Ruby Core Extensions in a gem}
  s.summary     = %q{Ruby Core Extension}
  
  s.rubyforge_project = "rcore-ext"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.require_paths = ["lib"]
  s.name          = "rcore-ext"
  s.version       = RCoreExt::VERSION

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  s.add_runtime_dependency "base32"
end
